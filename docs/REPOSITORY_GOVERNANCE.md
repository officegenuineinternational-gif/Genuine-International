# Repository Governance Verification

This document records the intended repository boundary:

- This public repository contains generic Genuine International tooling and non-sensitive documentation.
- HYROBOOKS engineering and operational authority remain in the private `officegenuineinternational-gif/HYROBOOKS` repository.
- Runtime state, live business data, credentials, backups, customer/vendor documents, and local evidence must not be committed here.
- Governance changes are validated by the Repository Governance workflow before merge.

The workflow itself uses read-only permissions and an immutable checkout action reference.
