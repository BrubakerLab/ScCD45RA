# Project Title
ScCD45RA is a simple model that predicts the CD45RA+/- label of cells in scRNA-seq analysis.

## Installation
```
pip install sccd45ra
```

## Usage
The function expects **pre-processed, normalized, and log-transformed (corrected count by SCTransform is also good)** scRNA-seq `AnnData`. To predict the CD45RA label, simply use the following:

```
from sccd45ra import cd45ra_infer
cd45ra_infer(adata)
```

and the prediction (a boolean array) will be added to the adata.obs as 'CD45RA_predict'. Call adata.obs['CD45RA_predict'] to see the result.


## Publication
biorxiv: [Enhanced Annotation of CD45RA to Distinguish T cell Subsets in Single Cell RNA-seq via Machine Learning](https://www.biorxiv.org/content/10.1101/2023.05.23.541821v1.full)
