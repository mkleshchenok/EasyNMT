"""
This example shows how EasyNMT can be used for sentence translation
"""
from easynmt import EasyNMT

sentences = ['Voici un exemple d\'utilisation d\'EasyNMT.',  # 'This is an example how to use EasyNMT.',
             'You can define a list of sentences.',
             # 'Each sentences is then translated to your chosen target language.',
             'Cada frase es luego traducida al idioma de destino seleccionado.',
             'On our website, you can find various translation models.',
             'New York City (NYC), often called simply New York, is the most populous city in the United States.',
             'PyTorch is an open source machine learning library based on the Torch library, used for applications such as computer vision and natural language processing, primarily developed by Facebook\'s AI Research lab (FAIR).',
             'A deep neural network (DNN) is an artificial neural network (ANN) with multiple layers between the input and output layers.']


target_lang = 'de'      # We want to translate the sentences to German (de)

model = EasyNMT('opus-mt')

translations = model.translate(
    sentences, target_lang=target_lang, batch_size=8, beam_size=3)
print(translations)
