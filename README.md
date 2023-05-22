# Project Title
ScCD45RA is a simple model that predict the CD45RA+/- label of cells in scRNA-seq analysis.

## Installation
```
pip install sccd45ra
```

## Usage
The function expects pre-processed, normalized, and log-transformed scRNA-seq AnnData. To predict the CD45RA label, simply use:

```
from sccd45ra import cd45ra_infer
cd45ra_infer(adata)
```
and the prediction will be added to the adata.obs as 'CD45RA_predict'

## Publication
TBA
