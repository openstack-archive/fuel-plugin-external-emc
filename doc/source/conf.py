from distutils.version import LooseVersion
from sphinx import __version__ as sphinx_version

source_suffix = '.rst'
master_doc = 'index'

project = u'EMC VNX plugin for Fuel'
copyright = u'2016, Mirantis Inc.'

version = '3.0'
release = '3.0-3.0.0-1'

pygments_style = 'sphinx'

latex_documents = [
  ('index','fuel-plugin-external-emc-doc.tex',
   u'Fuel EMC VNX plugin documentation',
   u'Mirantis Inc.', 'manual')
]

# Configuration for the latex/pdf docs.
latex_elements = {
    'papersize': 'a4paper',
    'pointsize': '11pt',
    # remove blank pages
    'classoptions': ',openany,oneside',
    'babel': '\\usepackage[english]{babel}',
}

if LooseVersion(sphinx_version) >= LooseVersion('1.3.1'):
    html_theme = "sphinx_rtd_theme"

html_add_permalinks = ""
html_show_copyright = False
highlight_language = 'none'
