wget https://s3.amazonaws.com/stratospark/food-101/model4b.10-0.68.hdf5
virtualenv -p /usr/bin/python2.7 env
source env/bin/activate
pip install tensorflow keras==1.2.2 coremltools h5py
python food101.py
deactivate
