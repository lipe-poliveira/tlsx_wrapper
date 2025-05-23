🛡️ tlsx-wrapper
Simple Shell script for extracting TLS Subject Alternative Names (SANs) using tlsx, with support for single URLs and lists, plus automatic deduplication.

✅ Dependencies
This script requires the following tools:

[Golang](https://go.dev/doc/install) — required for installing Go-based tools.

[tlsx](https://github.com/projectdiscovery/tlsx) — TLS certificate scanner.

[jq](https://github.com/jqlang/jq) — JSON parser. [I recommend installing jq here ](https://dspyt.medium.com/installing-jq-to-parse-json-52b19b7e2a2c)

[anew](https://github.com/tomnomnom/anew) — deduplication utility.


**How to Use**
```
1. Clone the repository:
git clone https://github.com/yourusername/tlsx-wrapper.git
cd tlsx-wrapper
chmod +x tlsx_wrapper.sh

2. Run for a single URL:
./tlsx_wrapper.sh -u target.com

3. Run for a list of subdomains:
./tlsx_wrapper.sh -l subdomains.txt
```
