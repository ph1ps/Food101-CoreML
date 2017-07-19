# Food101 for CoreML

### Description
This is the Food101 dataset implemented in Apple's new framework CoreML. The Food101 dataset can predict foods from images. The model was built with Keras 1.2.2 and is a **fine-tuned InceptionV3 model**.

To test this model you can open the `MNISTPrediction.xcodeproj` and run it on your device (iOS 11 and Xcode 9 is required). To test further images just add them to the project and replace my testing with yours.

I included the necessary preprocessing as an extension in my `ViewController.swift`. The model was trained to take 299x299 RGB images so keep an eye out for the right aspect ratio.

For further information about this dataset and how it was trained see my `food101.py` in the `Convert` directory or visit [Food101 Keras](https://github.com/stratospark/food-101-keras)

### Download
The model is not included in this repository since it would slow down git. I uploaded it on Google Drive, there you have to [download](https://drive.google.com/open?id=0B5TjkH3njRqnVjBPZGRZbkNITjA) it and drag it into the Xcode project.

### Retrain on your own
I've provided all scripts for the reproduction in the `Convert` directory. Make sure you call the `downloads_pretrained.sh` script first since you need the pretrained Keras model for conversion.

**TL;DR**

* `$ cd Convert`
* `$ ./download_pretrained.sh`
* `$ python food101.py`

If you are getting an error saying something with: `Fatal Python error: PyThreadState_Get: no current thread` then you need to do what **@hollance** did in [his repo](https://github.com/hollance/MobileNet-CoreML#converting-the-weights) (create a virtualenv). 

### Examples

<img src="lobster-screen.png" align="left" width="160">
<img src="ribs-screen.png" align="left" width="160">
<img src="steak-screen.png" align="left" width="160">
<img src="applepie-screen.png" align="left" width="160">
