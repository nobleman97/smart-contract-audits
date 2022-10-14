# Spin Token Audit Report

Issue ID | Severity | Location | Issue | Status 
| ---    | ---      | ---      | ---    | --- 
1  | low      | #66      | A more descriptive error message is required    | not fixed
2  | moderate | #108, #112, #116, #329, #330, #333, #334 | Functions lacks zero-check    | vulnerable
3  | low | #139 | Function "blacklistAddress" should be marked external   | not fixed
4  | low | #14, #15 | Remove unused libraries   | not fixed
5  | moderate | #5 | Compiler version 0.8.17 may be buggy. 0.8.7 or 0.8.9 is recommemded   | not fixed
6  | ```High``` | #27, #28, #29 | Contract contains unknown addresses. Please check hardcoded address and it's usage.   | vulnerable
7  | ```High``` | #14, #15 | Multiplication should be done before division to improve precision   | not fixed
8  | ```High``` | #324, #329 | Admin can withdraw BNB and tokens from contract   | vulnerable
9  | low | #324, #329, #333, #337, #115, #111 | functions should emit event   | not fixed


