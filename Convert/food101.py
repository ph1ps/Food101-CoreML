
from keras.models import load_model
import coremltools

model = load_model('./model4b.10-0.68.hdf5')

coreml_model = coremltools.converters.keras.convert(model, input_names=['image'], output_names=['foodConfidence'], class_labels='labels.txt')
coreml_model.author = 'Philipp Gabriel'
coreml_model.license = 'Unknown'
coreml_model.short_description = 'This model takes a picture of a food and predicts its name'
coreml_model.input_description['image'] = 'Image of a food'
coreml_model.output_description['foodConfidence'] = 'Confidence and label of predicted food'
coreml_model.output_description['classLabel'] = 'Label of predicted food'
coreml_model.save('Food101.mlmodel')
