module.exports =
class SearchPlatformDependentCharactersView
  constructor: (serializeState) ->
    @codes = require('./charcode')
    @buff = ""
    @line = 1
    # Register command
    atom.commands.add 'atom-workspace', 'search-platform-dependent-characters:checkSelection': => @checkSelection()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  checkCode: (code) ->
    ret = true
    #まずは7000文字種からざっくり半分で分ける
    if code < 29001
      ### 0 - 29000 ###
      #半分に分ける(2)
      if code < 19968
        ### 0 - 12542 ###
        #さらに半分に分ける(3)
        if code < 12288
          ### 0 - 9839 ジャッジ ###
          if code == 9 || code == 10 || code == 13
            #\t \r \n
            ret = true
          else if code >= 32 && code <=247
            ret = true
          else if @codes.from_913_to_1105.indexOf(code) != -1
            ret = true
          else if @codes.from_8208_to_9839.indexOf(code) != -1
            ret = true
          else
            ret = false
        else
          ### 12288 - 12542 ジャッジ ###
          if code >= 12353 && code <= 12435
            ret = true
          else if code >= 12449 && code <= 12534
            ret = true
          else if @codes.from_12288_to_12309.indexOf(code) != -1
            ret = true
          else if @codes.from_12443_to_12446.indexOf(code) != -1
            ret = true
          else if @codes.from_12539_to_12542.indexOf(code) != -1
            ret = true
          else
            ret = false
      else
        ### 19968 - 28988 ###
        #さらに半分に分ける(3)
        if code < 25001
          ### 19968 - 24999 ジャッジ ###
          if @codes.from_19968_to_20999.indexOf(code) != -1
            ret = true
          else if @codes.from_21000_to_21988.indexOf(code) != -1
            ret = true
          else if @codes.from_22007_to_22996.indexOf(code) != -1
            ret = true
          else if @codes.from_23001_to_23997.indexOf(code) != -1
            ret = true
          else if @codes.from_24009_to_24999.indexOf(code) != -1
            ret = true
          else
            ret = false
        else
          ### 25001 - 28988 ジャッジ ###
          if @codes.from_25001_to_25998.indexOf(code) != -1
            ret = true
          else if @codes.from_26000_to_26999.indexOf(code) != -1
            ret = true
          else if @codes.from_27000_to_27996.indexOf(code) != -1
            ret = true
          else if @codes.from_28003_to_28988.indexOf(code) != -1
            ret = true
          else
            ret = false
    else
      #### 29001 - 65509 ###
      #半分に分ける(2)
      if code < 36000
        ### 29001 - 35998 ###
        #さらに半分に分ける(3)
        if code < 32000
          ### 29001 - 31998 ジャッジ ###
          if @codes.from_29001_to_29996.indexOf(code) != -1
            ret = true
          else if @codes.from_30000_to_30994.indexOf(code) != -1
            ret = true
          else if @codes.from_31001_to_31998.indexOf(code) != -1
            ret = true
          else
            ret = false
        else
          ### 32000 - 35998 ジャッジ ###
          if @codes.from_32000_to_32997.indexOf(code) != -1
            ret = true
          else if @codes.from_33007_to_33997.indexOf(code) != -1
            ret = true
          else if @codes.from_34000_to_34999.indexOf(code) != -1
            ret = true
          else if @codes.from_35007_to_35998.indexOf(code) != -1
            ret = true
          else
            ret = false
      else
        ### 36000 - 65509###
        #さらに半分に分ける(3)
        if code < 39000
          ### 36000 - 38997 ジャッジ ###
          if @codes.from_36000_to_36999.indexOf(code) != -1
            ret = true
          else if @codes.from_37001_to_37994.indexOf(code) != -1
            ret = true
          else if @codes.from_38000_to_38997.indexOf(code) != -1
            ret = true
          else
            ret = false
        else
          ### 39000 - 65509 ###
          if @codes.from_39000_to_39998.indexOf(code) != -1
            ret = true
          else if @codes.from_40006_to_40864.indexOf(code) != -1
            ret = true
          else if @codes.from_65281_to_65509.indexOf(code) != -1
            ret = true
          else
            ret = false

    return ret

  # Toggle the visibility of this view
  checkSelection: ->
    console.time "checkcode"
    @buff = ""
    @line = 1

    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    # get select text(string)
    selectedText = editor.getSelectedText()
    len = selectedText.length
    idx = 0

    if len <= 0
      return

    while(true)
      # get target Char
      targetChar = selectedText.charAt(idx)
      targetCharCode = targetChar.charCodeAt(0)

      if targetCharCode is 10
        @line++

      # check code
      unless @checkCode(targetCharCode)
        maxTextLen = 30
        if(idx < maxTextLen)
          maxTextLen = idx
        @buff = selectedText.substr(idx - maxTextLen,maxTextLen)
        @fail()
        break

      # increment char-idx
      idx++
      if(idx >= len)
        @success()
        break

    console.timeEnd "checkcode"

  success: ->
    alert "[O] No exist platform-dependent-characters."

  fail: ->
    alert "[X] Exist platform-dependent-characters." + "\n\n"+ "Relative Line(in current selection): " + @line + "\n\n" + "Nearby: " +"\n" + @buff
