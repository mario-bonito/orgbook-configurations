.  $(find . -name overrides.inc)
# ================================================================================================================
# Special deployment parameters needed for injecting a user supplied settings into the deployment configuration
# ----------------------------------------------------------------------------------------------------------------

if createOperation; then
  # Ask the user to supply the sensitive parameters ...
  readParameter "WALLET_KEY - Please provide the wallet encryption key for the environment.  If left blank, a 48 character long base64 encoded value will be randomly generated using openssl:" WALLET_KEY $(generateKey) "false"
  readParameter "WALLET_SEED - Please provide the indy wallet seed for the environment.  If left blank, a seed will be randomly generated using openssl:" WALLET_SEED $(generateSeed) "false"
  readParameter "WALLET_DID - Please provide the indy wallet did for the environment.  The default is an empty string:" WALLET_DID "" "false"
else
  # Secrets are removed from the configurations during update operations ...
  printStatusMsg "Update operation detected ...\nSkipping the prompts for WALLET_KEY, WALLET_SEED, and WALLET_DID secrets ... \n"
  writeParameter "WALLET_KEY" "prompt_skipped" "false"
  writeParameter "WALLET_SEED" "prompt_skipped" "false"
  writeParameter "WALLET_DID" "prompt_skipped" "false"
fi

SPECIALDEPLOYPARMS="--param-file=${_overrideParamFile}"
echo ${SPECIALDEPLOYPARMS}