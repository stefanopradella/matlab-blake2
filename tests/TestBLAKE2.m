classdef TestBLAKE2 < matlab.unittest.TestCase

    properties (TestParameter)
        inputData = {'abc'}
        refOutput = {'BA80A53F981C4D0D6A2797B69F12F6E94C212F14685AC4B74B12BB6FDBFFA2D17D87C5392AAB792DC252D5DE4533CC9518D38AA8DBF1925AB92386EDD4009923', ...
            }
    end

    methods (Test, ParameterCombination = 'sequential')
        function BLAKE2b_512_abc_unkeyed(testCase, inputData, refOutput)
            % RFC 7693 - Appendix A

            nn = 64;        % Digest size in bytes
            kk = 0;         % Key size in bytes
            ll = numel(inputData);

            params = blake2impl.Constants.BLAKE2b;
            d = blake2impl.asciiStringToUint64(inputData, 16);
            
            digest = blake2impl.blake2(d, ll, kk, nn, params);

            testCase.verifyEqual(testCase.bytesToHex(digest), refOutput);
        end
    end

    methods (Static, Access = private)
        function hex = bytesToHex(bytes)
            hex = reshape(dec2hex(bytes, 2)', 1, []);
        end
    end
end
