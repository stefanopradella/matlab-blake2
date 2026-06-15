function words = bytesToUint64(text, outputSize)
% asciiStringToUint64 Convert text or uint8 data to uint64 words
%
% Example:
%   dec2hex(blake2impl.bytesToUint64("abc", 1), 16)
%   % returns "0000000000636261"

    arguments
        text        (:, 1)  char
        outputSize  (1, 1)  double {mustBeInteger, mustBeNonnegative}
    end

    inputBytes = uint8(text(:).');
    nBytes = 8 * outputSize;

    paddedBytes = zeros(1, nBytes, "uint8");
    paddedBytes(1:numel(inputBytes)) = inputBytes;

    words = zeros(outputSize, 1, "uint64");
    for wordIndex = 1:outputSize
        byteOffset = 8 * (wordIndex - 1);
        for byteIndex = 1:8
            shift = 8 * (byteIndex - 1);
            words(wordIndex) = bitor(words(wordIndex), ...
                bitshift(uint64(paddedBytes(byteOffset + byteIndex)), shift));
        end
    end
end