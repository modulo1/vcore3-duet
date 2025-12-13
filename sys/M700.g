if exists(param.S)
    then M98 P"0:/macros/ERCFv2/MOVE_SELECTOR_TO.G" S{param.S}
else 
  abort: missing param.S
