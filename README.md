# shellscraping
This repository collects my scraping codes which I uploaded on [My Gist] **written in Bash**.
[日本語版READMEはこちら]
# contents
- all-clone
  - Execute cloning **all public repos** of a specific user.
  - This uses `https://api.github.com/users/[github_userid]/repos` API.
- all-clone-gist.sh
  - Execute cloning **all Gist public repos** of a specific user.
  - This uses `https://api.github.com/users/[github_userid]/gists?page=[p]` API
- band-all.sh
  - Download **all Albums of a specipic user** from `Bandcamp`.
  - Fetch user's Albums from `https://<username>.bandcamp.com/music`.
    - `$ ./band-all.sh sabacanrecords`
  - [iheanyi/bandcamp-dl](https://github.com/iheanyi/bandcamp-dl) Wrapper
- hubsearch.sh
  - Search `GitHub`.
  - Scrape `https://github.com/search?q=[query]`.
- link-L1.sh
  - Extract **elements `href` from [maltinerecords/release]**.
- link-L2.sh
  - A LEVEL=2 version of `link-L1.sh`.
  - Extract **Archive / Track File URI** from the extracted Album pages.
- lyric-extractor.sh
  - Extract **lyrics from lyrics site**
  - Available sites:
    - http://j-lyric.net/
    - https://www.uta-net.com/
    - https://utaten.com/
    - http://www.kget.jp/
    - https://genius.com/
  - Unavailable sites:
    - https://kashinavi.com/
    - https://www.utamap.com/
- makelist.sh
  - Get **a list of languages** that GitHub supports syntax highlighting.
  - Source: [language.yml](https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml)
  - One-linear
- maltine-zips-download.sh
  - Download **DL-able albums / tracks** of [maltinerecords] and **compile them into a ZIP**.

[日本語版READMEはこちら]: https://github.com/eggplants/shellscraping/blob/master/README_ja.md
[My Gist]: https://gist.github.com/eggplants
[maltinerecords]: http://maltinerecords.cs8.biz/release.html
