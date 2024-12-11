"""Setup configuration for Next-Step AI package."""

from setuptools import find_packages, setup

setup(
    name="next_step_ai",
    version="0.1.0",
    packages=find_packages(),
    python_requires=">=3.12",
    install_requires=[
        "numpy",
        "pandas",
        "scikit-learn",
        "lightgbm",
        "pre-commit",
        "joblib",
    ],
)
