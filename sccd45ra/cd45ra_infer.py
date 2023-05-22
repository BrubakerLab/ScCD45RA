import scanpy as sc
import numpy as np
import pandas as pd
from joblib import dump, load
import pkg_resources

def cd45ra_infer(adata, inplace = True):
    
    print("This function takes normalized, log transformed input")
    _adata_df = pd.DataFrame(adata.X.A, index = adata.obs_names, columns = adata.var_names)
    _model_path = pkg_resources.resource_filename('sccd45ra', 'model/best_rbf_svm.joblib')
    _model = load(_model_path)
    _feature_path= pkg_resources.resource_filename('sccd45ra', 'feature/Supplement Tables.xlsx')
    _best_rbf_svm_features = pd.read_excel(_feature_path, sheet_name = 'S3')['RBF SVM'].dropna()
    _org_df = pd.DataFrame()
    for i in _best_rbf_svm_features:
        if i in _adata_df.columns:
            _org_df[i] = _adata_df[i]
        else:
            _org_df[i] = np.zeros(_adata_df.shape[0])
    
    if inplace == True:
        adata.obs['CD45RA_predict'] = _model.predict(_org_df)
    else:
        _prediction =  _model.predict(_org_df)
        return _prediction
