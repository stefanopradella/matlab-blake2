classdef TestBLAKE2 < matlab.unittest.TestCase

    methods (Test)
        function BLAKE2b_512_abc_unkeyed(testCase)
            % RFC 7693 - Appendix A

            inputData       = 'abc';
            expectedValue   = 'BA80A53F981C4D0D6A2797B69F12F6E94C212F14685AC4B74B12BB6FDBFFA2D17D87C5392AAB792DC252D5DE4533CC9518D38AA8DBF1925AB92386EDD4009923';
            
            digest = blake2b(inputData);

            testCase.verifyEqual(digest, expectedValue);
        end

        function BLAKE2b_512_abc_keyed(testCase)

            inputData       = 'abc';
            key             = 'qwerty';
            expectedValue   = '7427847542E38AFF0B2FB6DA838089A1555B636C42400DA4FAE68135D2BBC57CD8904E2D3C97C7A05036A59B5D9E9D52C9C4E400BBFE7D327E44AEDAC8E5B044';

            digest = blake2b(inputData, 64, key);

            testCase.verifyEqual(digest, expectedValue);
        end

        function BLAKE2s_256_abc_unkeyed(testCase)
            % RFC 7693 - Appendix B

            inputData       = 'abc';
            expectedValue   = '508C5E8C327C14E2E1A72BA34EEB452F37458B209ED63A294D999B4C86675982';
            
            digest = blake2s(inputData);

            testCase.verifyEqual(digest, expectedValue);
        end

        function BLAKE2s_256_abc_keyed(testCase)

            inputData       = 'abc';
            key             = 'qwerty';
            expectedValue   = '18924839C62B0525DBA245F497EFCE620E9890DD2843557359CA5B0F7ED7470D';
            
            digest = blake2s(inputData, 32, key);

            testCase.verifyEqual(digest, expectedValue);
        end
    end
end
