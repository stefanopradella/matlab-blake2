function words = bytesToWordVector(inputData, N, outputSize)
% bytesToUint64 Convert text or uint8 data to a padded uintN words vector
%
% Example:
%   dec2hex(blake2impl.bytesToWordVector("abc", 1), 64, 16)
%   % returns "0000000000636261"

    arguments
        inputData       (:, 1)  char
        N               (1, 1)  double
        outputSize      (1, 1)  double {mustBeInteger, mustBeNonnegative}
    end

    bytesPerWord = N/8;
    bytesPerBlock = bytesPerWord * outputSize;
    inputBytes = uint8(inputData(:).');

    if isempty(inputBytes)
        words = zeros(outputSize, 0, "uint"+num2str(N));
        return
    end

    nBlocks = ceil(numel(inputBytes) / bytesPerBlock);
    nBytes = bytesPerBlock * nBlocks;

    paddedBytes = zeros(1, nBytes, "uint8");
    paddedBytes(1:numel(inputBytes)) = inputBytes;

    words = zeros(outputSize, nBlocks, "uint"+num2str(N));
    for blockIndex = 1:nBlocks
        blockOffset = bytesPerBlock * (blockIndex - 1);
        for wordIndex = 1:outputSize
            byteOffset = blockOffset + bytesPerWord * (wordIndex - 1);
            for byteIndex = 1:bytesPerWord
                shift = 8 * (byteIndex - 1);
                words(wordIndex, blockIndex) = bitor(words(wordIndex, blockIndex), ...
                    bitshift(cast(paddedBytes(byteOffset + byteIndex), 'like', words), shift, "uint"+num2str(N)));
            end
        end
    end
end
