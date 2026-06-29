# matlab-blake2

[![View matlab-blake2 on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://it.mathworks.com/matlabcentral/fileexchange/184162-matlab-blake2)

MATLAB-native implementation of the BLAKE2 hashing algorithm based on [RFC 7693](https://datatracker.ietf.org/doc/html/rfc7693.html).
Supports BLAKE2b and BLAKE2s, configurable digest length, and optional keyed hashing.

```matlab
digest = blake2b('abc');            % 64-byte uint8 digest
digest = blake2s('abc', 32, 'key'); % Keyed BLAKE2s digest
```

Tested on MATLAB R2025b. No add-on dependencies.

License: MIT.

> **Note:** The GitHub repository is a mirror used to publish releases to MATLAB File Exchange.
> For contributions, please open pull requests on the main repo on [Codeberg](https://codeberg.org/stefanopradella/matlab-blake2).
