# Investment

## Getting started
[conda cheat sheet](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)
[git cheat sheet](https://about.gitlab.com/images/press/git-cheat-sheet.pdf)
Install environment and download data from Yahoofinance

```
conda env create -f conda_dev_environemnt.yml
conda activate investment
pip install -r requirements.dev.txt
```

Download data from YahooFinance: 
```
python download.py
```
