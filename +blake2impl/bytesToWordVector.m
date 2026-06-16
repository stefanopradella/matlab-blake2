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

    if isempty(inputData)
        words = [];
        return
    end
    
    bytesPerWord = N/8;
    inputBytes = uint8(inputData(:).');
    nBytes = bytesPerWord * outputSize;

    paddedBytes = zeros(1, nBytes, "uint8");
    paddedBytes(1:numel(inputBytes)) = inputBytes;

    words = zeros(outputSize, 1, "uint"+num2str(N));
    for wordIndex = 1:outputSize
        byteOffset = bytesPerWord * (wordIndex - 1);
        for byteIndex = 1:bytesPerWord
            shift = 8 * (byteIndex - 1);
            words(wordIndex) = bitor(words(wordIndex), ...
                bitshift(cast(paddedBytes(byteOffset + byteIndex), 'like', words), shift, "uint"+num2str(N)));
        end
    end
end