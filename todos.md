-   Update Readme.md
    -   Segment sub-topics into `docs`-dir
-   Install all necessary vagrant-plugins beforehand/globally?
-   Make PHP-Version configurable through .env
-   Make Gitify-Paths configurable through .env
-   Make OpenSSL-Version configurable through .env
    -   Install OpenSSL only if version is specified & version not already installed
    -   Create certificate only if version is specified & certificate not already exist
-   [ ] make own ansible sql set up file from geerlingguy.mysql
    -   getting this error
    ```sh
    fatal: [modx]: FAILED! => {"changed": false, "msg": "value of state must be one of: absent, build-dep, fixed, latest, present, got: installed"}
    ```
