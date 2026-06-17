classdef TestBLAKE2Selftest < matlab.unittest.TestCase
% RFC 7693 - Appendix E

    properties (Constant)
        blake2b_res = [ 0xC2, 0x3A, 0x78, 0x00, 0xD9, 0x81, 0x23, 0xBD, ...
                        0x10, 0xF5, 0x06, 0xC6, 0x1E, 0x29, 0xDA, 0x56, ...
                        0x03, 0xD7, 0x63, 0xB8, 0xBB, 0xAD, 0x2E, 0x73, ...
                        0x7F, 0x5E, 0x76, 0x5A, 0x7B, 0xCC, 0xD4, 0x75]
        b2b_md_len = [20 32 48 64];
        b2b_in_len = [0 3 128 129 255 1024];

        blake2s_res = [ 0x6A, 0x41, 0x1F, 0x08, 0xCE, 0x25, 0xAD, 0xCD, ...
                        0xFB, 0x02, 0xAB, 0xA6, 0x41, 0x45, 0x1C, 0xEC, ...
                        0x53, 0xC5, 0x98, 0xB2, 0x4F, 0x4F, 0xC7, 0x87, ...
                        0xFB, 0xDC, 0x88, 0x79, 0x7F, 0x4C, 0x1D, 0xFE]
        b2s_md_len = [16 20 28 32];
        b2s_in_len = [0 3 64 65 255 1024];

    end

    methods (Test)
        function BLAKE2b_selftest(testCase)
            % digest = TestBLAKE2Selftest.blake2b_selftest_digest();
            hashBytes = zeros(1, ...
                2 * numel(TestBLAKE2Selftest.b2b_in_len) * sum(TestBLAKE2Selftest.b2b_md_len), ...
                'uint8');
            hashIndex = 1;


            for i = 1:4
                outlen = TestBLAKE2Selftest.b2b_md_len(i);

                for j = 1:6
                    inlen = TestBLAKE2Selftest.b2b_in_len(j);
                    inputBytes = TestBLAKE2Selftest.selftest_seq(inlen, inlen);

                    % Unkeyed hash
                    md = blake2b(inputBytes, outlen);
                    mdBytes = TestBLAKE2Selftest.hexToBytes(md);
                    hashBytes(hashIndex:(hashIndex + outlen - 1)) = mdBytes;
                    hashIndex = hashIndex + outlen;

                    % Keyed hash
                    keyBytes = TestBLAKE2Selftest.selftest_seq(outlen, outlen);
                    md = blake2b(inputBytes, outlen, keyBytes);
                    mdBytes = TestBLAKE2Selftest.hexToBytes(md);
                    hashBytes(hashIndex:(hashIndex + outlen - 1)) = mdBytes;
                    hashIndex = hashIndex + outlen;
                
                end
            end

            digest = blake2b(hashBytes, 32);

            testCase.verifyEqual(digest, blake2impl.bytesToHex(testCase.blake2b_res));
        end

        function BLAKE2s_selftest(testCase)
            hashBytes = zeros(1, ...
                2 * numel(TestBLAKE2Selftest.b2s_in_len) * sum(TestBLAKE2Selftest.b2s_md_len), ...
                'uint8');
            hashIndex = 1;


            for i = 1:4
                outlen = TestBLAKE2Selftest.b2s_md_len(i);

                for j = 1:6
                    inlen = TestBLAKE2Selftest.b2s_in_len(j);
                    inputBytes = TestBLAKE2Selftest.selftest_seq(inlen, inlen);

                    % Unkeyed hash
                    md = blake2s(inputBytes, outlen);
                    mdBytes = TestBLAKE2Selftest.hexToBytes(md);
                    hashBytes(hashIndex:(hashIndex + outlen - 1)) = mdBytes;
                    hashIndex = hashIndex + outlen;

                    % Keyed hash
                    keyBytes = TestBLAKE2Selftest.selftest_seq(outlen, outlen);
                    md = blake2s(inputBytes, outlen, keyBytes);
                    mdBytes = TestBLAKE2Selftest.hexToBytes(md);
                    hashBytes(hashIndex:(hashIndex + outlen - 1)) = mdBytes;
                    hashIndex = hashIndex + outlen;
                
                end
            end

            digest = blake2s(hashBytes, 32);

            testCase.verifyEqual(digest, blake2impl.bytesToHex(testCase.blake2s_res));
        end
    end

    methods (Static, Access = private)

        function out = selftest_seq(len, seed)
            out = zeros(1, len, 'uint8');
            a = blake2impl.mul32(uint32(hex2dec('DEAD4BAD')), uint32(seed));
            b = uint32(1);

            for i = 1:len
                t = blake2impl.add32(a, b);

                a = b;
                b = t;

                out(i) = uint8(bitshift(t, -24));
            end
        end

        function bytes = hexToBytes(hex)
            bytes = uint8(sscanf(hex, '%2x').');
        end
    end
end
