import setuptools

setuptools.setup(
    name="face_detection",
    python_requires='>=3.6',
    license="apache-2.0",
    classifiers=[
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: OS Independent",
    ],
    install_requires=[
        "torch>=1.6",
        "torchvision>=0.3.0",
        "numpy",
    ],
    packages=setuptools.find_packages()
)
