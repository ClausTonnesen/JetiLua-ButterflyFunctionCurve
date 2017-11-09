local appName="Butterfly function curve input" 
local appDescription1="1. Create function ButterflyControl" 
local appDescription2="   with desired input as control" 
local appDescription3="2. Assign the funtion to a servo" 
local appDescription4="3. Specify the servo number here" 
local appDescription5="4. In Butterfly use app control BFL" 
local ctrlOutCreated
local servoNumber

local function servoNumberChanged(value)
  servoNumber=value
  system.pSave("_BFL_servoNumber",value)
end


local function initForm(subform)
  form.addLabel({label=appDescription1})
  form.addLabel({label=appDescription2})
  form.addLabel({label=appDescription3})
  form.addRow(2)
  form.addLabel({label=appDescription4, width=240})
  form.addIntbox (servoNumber, 1, 24, 16,0, 1, servoNumberChanged)
  form.addLabel({label=appDescription5})
end


-- Init function
local function init() 
  system.registerForm(1,MENU_ADVANCED,appName,initForm) 

  servoNumber = system.pLoad("_BFL_servoNumber")
  if (not servoNumber) then
    servoNumber = 16
    system.pSave("_BFL_servoNumber",value)
  end
  
--  local ctrlNumber = 1
--  while (not ctrlOutCreated) do
--    ctrlOutCreated = system.registerControl(ctrlNumber, "Butterfly via servo output","BFL")
--    ctrlNumber = ctrlNumber + 1
--  end

-- Use fixed control number, might collide with other scripts, but ensures control always is on the specific number and not dependant on script loading order.
  ctrlOutCreated = system.registerControl(2, "Butterfly via servo output","BFL")
end

-- Loop function
local function loop()   
  if(ctrlOutCreated and servoNumber) then
    system.setControl(ctrlOutCreated, system.getInputs("O"..servoNumber) ,0,0)
  end
end

return { init=init, loop=loop, author="ClausT on JetiForum.de", version="1.04",name=appName}