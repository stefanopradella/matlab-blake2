classdef TestBLAKE2 < matlab.unittest.TestCase

    methods (Test)
        function BLAKE2b_512_abc_unkeyed(testCase)
            % RFC 7693 - Appendix A

            inputData       = 'abc';
            expectedValue   = 'BA80A53F981C4D0D6A2797B69F12F6E94C212F14685AC4B74B12BB6FDBFFA2D17D87C5392AAB792DC252D5DE4533CC9518D38AA8DBF1925AB92386EDD4009923';

            nn = 64;                % Digest size in bytes
            kk = 0;                 % Key size in bytes
            ll = numel(inputData);

            params = blake2impl.Constants.BLAKE2b;
            d = blake2impl.bytesToUint64(inputData, 16);
            
            digest = blake2impl.blake2(d, ll, kk, nn, params);

            testCase.verifyEqual(digest, expectedValue);
        end
    end

    methods (Test)
        function BLAKE2b_512_abc_keyed(testCase)

            inputData       = 'abc';
            key             = 'qwerty';
            expectedValue   = '7427847542E38AFF0B2FB6DA838089A1555B636C42400DA4FAE68135D2BBC57CD8904E2D3C97C7A05036A59B5D9E9D52C9C4E400BBFE7D327E44AEDAC8E5B044';

            nn = 64;                % Digest size in bytes
            kk = numel(key);        % Key size in bytes
            ll = numel(inputData);

            params = blake2impl.Constants.BLAKE2b;
            d = blake2impl.bytesToUint64(inputData, 16);
            d = [blake2impl.bytesToUint64(key, 16), d];

            digest = blake2impl.blake2(d, ll, kk, nn, params);

            testCase.verifyEqual(digest, expectedValue);
        end
    end
end
