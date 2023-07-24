from setuptools import setup, find_packages

setup(
    name="sccd45ra",
    version="0.3.2",
    packages=find_packages(),
    package_data={
        'sccd45ra': ['model/*.h5ad', 'model/*.joblib','feature/*.xlsx'],
    },
    install_requires=[
        "scanpy",
        "numpy",
        "pandas",
        "anndata>=0.8.0",
        "joblib",
        "scikit-learn",
        "setuptools"
    ]
)
