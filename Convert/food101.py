import coremltools

coreml_model = coremltools.converters.keras.convert('./model4b.10-0.68.hdf5', input_names=['image'], output_names=['foodConfidence'], class_labels='labels.txt', image_input_names=['image'], image_scale=2/255.0, red_bias=-1, green_bias=-1, blue_bias=-1)
coreml_model.author = 'Philipp Gabriel'
coreml_model.license = 'MIT'
coreml_model.short_description = 'This model takes a picture of a food and predicts its name'
coreml_model.input_description['image'] = 'Image of a food'
coreml_model.output_description['foodConfidence'] = 'Confidence and label of predicted food'
coreml_model.output_description['classLabel'] = 'Label of predicted food'
coreml_model.save('Food101.mlmodel')
