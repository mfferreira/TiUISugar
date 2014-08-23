_ = require 'vendor/lodash'

indWin = actInd = null
indicatorActive = false

class TiUber

  constructor: ->
    @defaultConfig = {}
    @object_ids = {}
    @_ = _

    @NO_SELECTION_ROW = Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
    @FLEXSPACE = Ti.UI.createButton({ systemButton:Ti.UI.iPhone.SystemButton.FLEXIBLE_SPACE })

  getById: (id) =>
    @object_ids[data.id]

  applyConfig: (uiElement, configName) =>
    Ti.API.debug JSON.stringify(@defaultConfig[configName])
    uiElement.applyProperties(@defaultConfig[configName])

  genericBuilder: (uiElement, data) =>
    data = data or {}
    if data.config and @defaultConfig[data.config]
      data.properties = _.extend(_.clone(@defaultConfig[data.config]), data.properties)

    obj = uiElement(data.properties or {})
    if data.content
      obj.add(_content) for _content in data.content
    if data.events
      obj.addEventListener(event_[0], event_[1]) for event_ in data.events
    if data.id
      object_ids[data.id] = obj
    obj

  currentWindow: -> Ti.UI.currentWindow

  win: (data) =>
    @genericBuilder(Ti.UI.createWindow, data)

  navigationWindow: (data) =>
    @genericBuilder(Ti.UI.iOS.createNavigationWindow, data)

  view: (data) =>
    @genericBuilder(Ti.UI.createView, data)

  scrollView: (data) =>
    @genericBuilder(Ti.UI.createScrollView, data)

  textField: (data) =>
    @genericBuilder(Ti.UI.createTextField, data)

  textArea: (data) =>
    @genericBuilder(Ti.UI.createTextArea, data)

  button: (data) =>
    @genericBuilder(Ti.UI.createButton, data)

  buttonBar: (data) =>
    @genericBuilder(Ti.UI.createButtonBar, data)

  table: (data) =>
    @genericBuilder(Ti.UI.createTableView, data)

  row: (data) =>
    @genericBuilder(Ti.UI.createTableViewRow, data)

  section: (data) =>
    @genericBuilder(Ti.UI.createTableViewSection, data)

  tabbedBar: (data) =>
    @genericBuilder(Ti.UI.iOS.createTabbedBar, data)

  buttonBar: (data) =>
    @genericBuilder(Ti.UI.createButtonBar, data)

  image: (data) =>
    @genericBuilder(Ti.UI.createImageView, data)

  Switch: (data) =>
    @genericBuilder(Ti.UI.createSwitch, data)

  slider: (data) =>
    @genericBuilder(Ti.UI.createSlider, data)

  popover: (data) =>
    @genericBuilder(Ti.UI.iPad.createPopover, data)

  picker: (data) =>
    @genericBuilder(Ti.UI.createPicker, data)

  searchBar: (data) =>
    @genericBuilder(Ti.UI.createSearchBar, data)

  scrollableView: (data) =>
    @genericBuilder(Ti.UI.createScrollableView, data)

  activityIndicator: (data) =>
    @genericBuilder(Ti.UI.createActivityIndicator, data)

  attributedString: (data) =>
    @genericBuilder(Ti.UI.iOS.createAttributedString, data)

  label: (properties, events) =>
    label = if properties.config then @genericBuilder(Ti.UI.createLabel, properties) else Ti.UI.createLabel(properties)
    if events
      label.addEventListener(event_[0], event_[1]) for event_ in events
    label

  optionDialog: (data) =>
    @genericBuilder(Ti.UI.createOptionDialog, data)

  animation: (data) =>
    @genericBuilder(Ti.UI.createAnimation, data)

  addEvents: (obj, events) =>
    if events
      obj.addEventListener(event_[0], event_[1]) for event_ in events
    obj

  alert: (data) =>
    @genericBuilder(Ti.UI.createAlertDialog, data)

  resetChecks: (tableData) =>
    # removes check from all rows
    for section in tableData
      for row in section.rows
        # Ti.API.debug section.rows[k]
        row.hasCheck = false
        row.children[0].color = '#000000'
    tableData

  showIndicator: (message) =>
    Ti.API.debug 'Opening activity indicator'
    if not indicatorActive
      actInd = Ti.UI.createActivityIndicator({ height:30, width:30 })
      actInd.style = Ti.UI.iPhone.ActivityIndicatorStyle.BIG
      indWin = Ti.UI.createWindow()
      indView = Ti.UI.createView({ height:100, width:100, backgroundColor:'#000', borderRadius:5, opacity:0.7 })
      indWin.add(indView)
      indWin.add(actInd)
      indWin.open()
      actInd.show()
      indicatorActive = true

  hideIndicator: =>
    Ti.API.debug 'Hiding activity indicator'
    if indicatorActive
      actInd.hide()
      indWin.close()
      indicatorActive = false


ui = new TiUber()
# ui.defaultConfig = require your theme here

module.exports = ui
