classdef TestBLAKE2bPython < matlab.unittest.TestCase
% Test BLAKE2 functions against the python reference implementation.
% To run this class, you must have python installed with hashlib.

    properties (Constant)
        NumRandomVectors = 64
        MaxMessageBytes = 1024
    end

    methods (Test)
        function BLAKE2b_random_unkeyed(testCase)
            stream              =   RandStream("mt19937ar", "Seed", 4202);
            hashlib             =   py.importlib.import_module('hashlib');

            % Extract random message sizes, along with some fixed value to
            % test typical length and corner cases
            messageSizes        =   [0, 1, 2, 63, 64, 65, 127, 128, 129, 255, 256, 257, ...
                                        randi(stream, [0 testCase.MaxMessageBytes], 1, testCase.NumRandomVectors)];

            for testIndex = 1:numel(messageSizes)

                messageBytes    =   testCase.getRandomBytes(stream, messageSizes(testIndex));
                digestSize      =   randi(stream, [1 64], 1, 1);

                digest          =   blake2b(char(messageBytes.'), digestSize);
                expectedDigest  =   testCase.pythonBlake2b(hashlib, messageBytes, digestSize);

                testCase.verifyEqual(digest, expectedDigest, ...
                    sprintf('Message size: %d\nDigest size: %d', numel(messageBytes), digestSize));
            end
        end

        function BLAKE2b_random_keyed(testCase)
            stream              =   RandStream("mt19937ar", "Seed", 9917);
            hashlib             =   py.importlib.import_module('hashlib');
            
            % Extract random message sizes, along with some fixed value to
            % test typical length and corner cases
            messageSizes        =   [0, 1, 2, 63, 64, 65, 127, 128, 129, 255, 256, 257, ...
                                        randi(stream, [0 testCase.MaxMessageBytes], 1, testCase.NumRandomVectors)];

            for testIndex = 1:numel(messageSizes)
                messageBytes    =   testCase.getRandomBytes(stream, messageSizes(testIndex));
                keyBytes        =   testCase.getRandomBytes(stream, randi(stream, [1, 64], 1, 1));
                digestSize      =   uint8(randi(stream, [1, 64], 1, 1));

                digest          =   blake2b(char(messageBytes.'), digestSize, char(keyBytes.'));
                expectedDigest  =   testCase.pythonBlake2b(hashlib, messageBytes, digestSize, keyBytes);

                testCase.verifyEqual(digest, expectedDigest, ...
                    sprintf('Message size: %d\nKey size: %d\nDigest size: %d', ...
                    numel(messageBytes), numel(keyBytes), digestSize));
            end
        end
    end

    methods (Static, Access = private)
        function bytes = getRandomBytes(stream, n)
            bytes = uint8(randi(stream, [0, 255], 1, n));
        end

        function digest = pythonBlake2b(hashlib, messageBytes, digestSize, keyBytes)
            message = TestBLAKE2bPython.pythonBytes(messageBytes);

            if nargin < 4
                hash = hashlib.blake2b(message, pyargs('digest_size', int32(digestSize)));
            else
                key = TestBLAKE2bPython.pythonBytes(keyBytes);
                hash = hashlib.blake2b(message, pyargs('digest_size', int32(digestSize), 'key', key));
            end

            digest = char(hash.hexdigest().upper());
        end

        function value = pythonBytes(bytes)
            if isempty(bytes)
                value = py.bytes.fromhex('');
                return
            end

            hexBytes = reshape(dec2hex(bytes, 2).', 1, []);
            value = py.bytes.fromhex(hexBytes);
        end
    end
end
