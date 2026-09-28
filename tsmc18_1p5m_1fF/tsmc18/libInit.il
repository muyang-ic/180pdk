let( ( (libName "tsmc18") libId libPath encSkillPath srcSkillPath modelPath file element tools)
  libId = ddGetObj( libName )
  if( ddIsId( libId ) then
    libPath = ddGetObjReadPath( libId )

    printf( "Initializing from libInit.il for library %s...\n" libName )
    encSkillPath = strcat( libPath "/../skill")
; load .cdsenv file

  filePath = sprintf(nil "%s/.cdsenv" libPath)
  when( isFile(filePath) 
     printf("Loading cdsenv file  '%s'\n" filePath)
     envLoadFile(filePath)
  ) ; ** if isFile **

    loadContext(prependInstallPath("etc/context/pCellGen.cxt"))
    filePath = sprintf(nil "%s/pcellCode.cdn" encSkillPath)
    when( isFile(filePath)
        printf( "   --  %s\n" filePath )
        loadContext(sprintf(nil "/%s" filePath))
    )
    filePath = sprintf(nil "%s/mom.cdn" encSkillPath)
    when( isFile(filePath)
        printf( "   --  %s\n" filePath )
        loadContext(sprintf(nil "/%s" filePath))
    )

; load encrypted skill files
    foreach( file setof(element getDirFiles(encSkillPath) 
                          equal(".il" index(element ".il"))
                    )
      printf( "   --  %s\n" file )
      load( strcat( encSkillPath sprintf(nil "/%s" file)))
    )
    
; load encrypted skill files
    foreach( file setof(element getDirFiles(encSkillPath) 
                          equal(".cb" index(element ".cb"))
                    )
      printf( "   --  %s\n" file )
      load( strcat( encSkillPath sprintf(nil "/%s" file)))
    )

; load encrypted skill files
    foreach( file setof(element getDirFiles(encSkillPath) 
                          equal(".ile" index(element ".ile"))
                    )
      printf( "   --  %s\n" file )
      load( strcat( encSkillPath sprintf(nil "/%s" file)))
    )

; load encrypted callback files
    foreach( file setof(element getDirFiles(encSkillPath) 
                          equal(".cbe" index(element ".cbe"))
                    )
      printf( "   --  %s\n" file )
      load( strcat( encSkillPath sprintf(nil "/%s" file)))
    )

; load cxt files
    foreach( file setof(element getDirFiles(encSkillPath) 
                          equal(".cxt" index(element ".cxt"))
                    )
    if( file !="tsAbut.cxt" then
      printf( "   --  %s\n" file )
      loadContext( strcat( encSkillPath sprintf(nil "/%s" file)))
      )
    )
    
    
    filePath = sprintf(nil "%s/pdkParamTable.il" encSkillPath)
    when( isFile(filePath)
	printf("Loading PDK Param Table  '%s'\n" filePath)
        PasLoadPdkParams(libName filePath)
    )

    filePath = sprintf(nil "%s/display.drf" getWorkingDir())
    if( isFile( filePath) then
       printf("Loading Working place Display File '%s'\n" filePath)
    else
       filePath = sprintf(nil "%s/../display.drf" libPath)
       when( isFile(filePath)
           when( isCallable( 'drLoadDrf)
               printf("Loading PDK Display File '%s'\n" filePath)
               drLoadDrf(filePath)
           )
       )
    )
    
  else
  
    printf( "An error occured while initializing the libInit.il file.\n" )
    printf( "The library, %s, specified in this file, could\n" libName )
    printf( "not be found. If you have:\n" )
    printf( "    o   moved/copied the library to a new name.\n" )
    printf( "    o   edited this file and made a typographical error.\n" )
    printf( "    o   copied this file from another library.\n" )
    printf( "you must edit the libInit.il file and correct the\n" )
    printf( "library name.\n" )
    
  ); if ddIsId
;;    
;; Set the Spectre Model Path
;;
  if(isContextLoaded("schView") then
;     tool = (asiGetTool 'hspiceS)  
;       asiSetNetlistOption(tool 'maxMacroNameLength 64) 
;       asiSetNetlistOption(tool 'ihnlMaxNameLength 64) 
;       asiSetNetlistOption(tool 'maxModelNameLength 64)
  
;     envSetVal("asimenv.startup" "simulator" 'string "spectre")
;     libPath = ddGetObjReadPath( libId )
;     asiSetEnvOptionVal(asiGetTool('spectre) "modelFiles")
     
     foreach( sim list( 'ams 'UltraSim 'spectre)
     envSetVal("asimenv.startup" "simulator" 'string sprintf(nil "%s" sim))
     asiSetEnvOptionVal(asiGetTool(sim) "modelFiles"
     
                          list(
                               list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_dio_m")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_dio_3m")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_rtmom")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_bbmvar")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_disres")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_mim")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_3vna")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_dio_dnw")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_m")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_3m")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_res")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_bip3")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_bip")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_dio3")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_3v")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_dio")
	                             list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_na")
                                 list(strcat( libPath "/../models/spectre/cmn018_assp_v1d2.scs") "tt_fmom")
                              )
                        )
               )
               
      if(getd('eldoD) then
      asiSetEnvOptionVal(asiGetTool('eldoD) "modelFiles"
         list(
                               list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_dio_m")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_dio_3m")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_rtmom")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_bbmvar")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_disres")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_mim")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_3vna")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_dio_dnw")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_m")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_3m")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_res")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_bip3")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_bip")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_dio3")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_3v")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_dio")
	                             list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_na")             	    
                                 list(strcat( libPath "/../models/eldo/cmn018_assp_v1d2.eldo") "tt_fmom")
              )                                                           
                        )                                             
              
         );end eldoD if
              
     asiSetEnvOptionVal(asiGetTool('hspiceD) "modelFiles"
      	list( 
         		list(strcat( libPath "/../models/hspice/hspice.mdl") )
          	) 
                       ) ; asiSet...
              
;     asiSetEnvOptionVal(asiGetTool('hspiceS) "modelPath" strcat(libPath "/../models/hspice") )
;     asiSetEnvOptionVal(asiGetTool('hspiceS) "includeFile" "hspice.mdl")
              
;  if(getd('ADSsim) then
;     asiSetEnvOptionVal(asiGetTool('ADSsim) "modelFiles"
;                          list(
;                               list(strcat( libPath "/../models/ADS/rf018_inc.net") "")
;                               list(strcat( libPath "/../models/ADS/ResModel.net") "res_t")
;	                            )
;                       )
;    );end ADS if
  ); if schematic context is loaded

             
              
;; Set the VXL significan Digits
  when( getd('aelPushSignifDigits)
     aelPushSignifDigits(6)
  )

  auCdlPrintEmptySUBCKT = 'nil
  auCdlCDFPinCntrl = 't
  auCdlCheckLDD = 't


    ; Load PDK utility ------------------------------------------------------------------------
    if( isCallable('hiCreateMenuItem) && hiGraphicMode() then 
      when( isCallable('tsmcPdkAddCIWPulldown) 
          tsmcPdkAddCIWPulldown() 
      );when 
      when( isCallable('tsmcPdkToolAbout2)
          tsmcPdkToolAbout2("tsmc18")
      )
      
; Auto load Assura rules File and RSF setting
   
   TSMC_PDK_NAME = strcat("TSMC_PDK_NAME=" libName) 
   setShellEnvVar(TSMC_PDK_NAME)      
            
; Assura LVS to auto load source.added
   TSMC_PDK_ASSURA_SA_FILE = getShellEnvVar("assura_source_added_place")
   if(TSMC_PDK_ASSURA_SA_FILE then
     filePath = strcat("TSMC_PDK_source_added_place=cdl ::  " TSMC_PDK_ASSURA_LVS_FILE)
   else
     filePath = strcat("TSMC_PDK_source_added_place=cdl ::  " libPath "/../Assura/lvs_rcx/source.added")
   );if
   setShellEnvVar(filePath)
; Calibre LVS to auto load source.added
   filePath = getShellEnvVar("calibre_source_added_place")

   if(!filePath then
     filePath = strcat(libPath "/../Calibre/lvs/source.added")
   );if
   when(!boundp('cdlOutKeys) cdlOutKeys = list(nil) )
   cdlOutKeys->incFILE = filePath 
    
    );if(hiCreateMenuItem) 
    
);let



;; set for instance cellname editable
    procedure( tsmcCdfFormInitCB( cdfgData "g" )
    
        when( boundp( 'schObjPropForm ) && schObjPropForm->cellName
            schObjPropForm->cellName->editable = nil  ; 
        )
    ) 
    
envSetVal("adexl.gui" "pcfPrependBasePath" 'boolean t)
    

