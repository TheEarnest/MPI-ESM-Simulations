;----------------------------------------------------------------------
; dataonmap_1.ncl
;
; Concepts illustrated:
;   - Plotting contours on a rectilinear grid
;----------------------------------------------------------------------
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
;----------------------------------------------------------------------

begin
 
;  filename = "Diff_sample01-native_1900-2049-DJF.nc"
  filename = "Diff_sample-native_1900-2049-DJF.nc"
  Figure_title = "Sampling - Native (model year 1900-2049, DJF)"


  ;filename = "T_MDiff_CAM4_1000_snapshot_hM_timmean.nc"
  ;Figure_title = "Averaged Forecast Error ~C~ @ 700 hPa (ML) ~C~ 1982-01-16 to 1982-01-31"
  ;filename = "T_MDiff_CAM4_1000_snapshot.nc"
  ;Figure_title = "Forecast Error ~C~ @ 700 hPa (ML) ~C~ 1982-01-31 00-06 hr"

;  fig_name = "fig_2D_Glob_" + filename
  a = addfile(filename,"r")    ; open file

  var = a->u10(0,:,:)
  MinLevelValF = -1
  MaxLevelValF = 1
  LevelSpacingF = 0.1 
  fig_name = "fig_2D_Glob_zmld" + filename


;  var = a->aofltxwo(0,0,:,:)
;  MinLevelValF = -0.05
;  MaxLevelValF = 0.05
;  LevelSpacingF = 0.005
;  fig_name = "fig_2D_Glob_taux" + filename

;  var = a->aofltywe(0,0,:,:)
;  MinLevelValF = -0.05
;  MaxLevelValF = 0.05
;  LevelSpacingF = 0.005
;  fig_name = "fig_2D_Glob_tauy" + filename

;  var = a->aoflnhwo(0,0,:,:)
;  MinLevelValF = -60
;  MaxLevelValF = 60
;  LevelSpacingF = 3
;  fig_name = "fig_2D_Glob_netQ" + filename

;  var = a->psitro(0,0,:,:)
;  var = var/1e9
;  MinLevelValF = -4
;  MaxLevelValF = 4
;  LevelSpacingF = 0.4
;  fig_name = "fig_2D_Glob_BSF" + filename

;  var = a->sst(0,0,:,:)
;  MinLevelValF = -2
;  MaxLevelValF = 2
;  LevelSpacingF = 0.2
;  fig_name = "fig_2D_Glob_SST" + filename

;  var = a->sss(0,0,:,:)
;  MinLevelValF = -2
;  MaxLevelValF = 2
;  LevelSpacingF = 0.2
;  fig_name = "fig_2D_Glob_SSS" + filename

  printVarSummary(var)           ; print info about variable

;---Plot data
  wks_type = "pdf"        ; "gs" or "pdf"
  ;wks_type@wkOrientation = "landscape"
  ;wks_type@wkOrientation = "portrait"

  wks = gsn_open_wks(wks_type, fig_name)

  res              = True
  res@gsnMaximize  = False     ; maximize plot in frame
  res@cnFillOn     = True     ; turn on contour fill
  res@cnLinesOn    = False    ; turn off contour fill
  res@mpCenterLonF = 0

  res@mpMaxLatF                   = 80           ; choose subregion           
  res@mpMinLatF                   = 0
  res@mpMaxLonF                   = 50
  res@mpMinLonF                   = -100

  res@lbOrientation =   "vertical"          ; vertical label bar
  res@tiMainString = Figure_title
;  res@cnLevels     = ispan(-10,10,1)
  res@cnLevelSelectionMode = "ManualLevels"     ; set manual contour levels
  res@cnMinLevelValF       = MinLevelValF                ; set min contour level
  res@cnMaxLevelValF       = MaxLevelValF                ; set max contour level
  res@cnLevelSpacingF      = LevelSpacingF             ; set contour spacing

;  res@gsnPaperOrientation = "auto"          
;  res@gsnMaximize         = True        ; must include w/ Paper Orientation

  gsn_define_colormap(wks,"BlRe")

  plot = gsn_csm_contour_map(wks,var,res)

end
