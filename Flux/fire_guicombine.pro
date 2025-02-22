pro fire_guicombine, fire, $
                     targs=targs, $
                     groupleader=groupleader, $
                     WIDGET=widget, _EXTRA = keys, $
                     ORDERS=orders

  func_name = 'fire_guicombine'
  ntargs = n_elements(targs)
  used_tot = 0
  notused_tot = 0

  for itarg=0, ntargs-1 do begin
     
     outfile = 'FSpec/'+strtrim(targs[itarg],2)+'_F.fits'
     sigfile = 'FSpec/'+strtrim(targs[itarg],2)+'_E.fits'
     
     match = where(fire.object EQ targs[itarg] AND $
                   strtrim(strupcase(fire.exptype),2) EQ 'SCIENCE', nmatch)
     
     if nmatch EQ 0 then begin
        fire_siren, func_name + ": No files found for object " + targs[itarg] + "!"
        return
     endif else begin
        objstr_filenames = make_array( nmatch, 1, /string)
        used = make_array( nmatch, 1, value=0 )
     endelse
     first = 1

     ; Read in the individual files
     for imatch=0, nmatch-1 do begin        
        objstr_file = fire[match[imatch]].objstrfile
        objstr_filenames[imatch] = fire_get_fitnum(objstr_file)
        if (x_chkfil(objstr_file) EQ 1) then begin
           objstr = mrdfits(objstr_file,1,hdr)
        endif else continue
        gd = where(objstr.flux NE 0, ngd) ;; Has the telluric correction been applied?
        if (ngd EQ 0) then begin
           print,func_name+": WARNING, this file is not telluric/flux corrected, skipping (" + $
                 objstr_file + ")"
           continue
        endif else begin
           used[imatch] = 1        
        endelse
        
        if (first EQ 1) then begin
           all_objstr = objstr
           output_hdr = hdr
           first = 0
           total_exptime = sxpar(hdr,"EXPTIME")
        endif else begin
           all_objstr = [all_objstr,objstr]
           total_exptime += sxpar(hdr,"EXPTIME")
        endelse
     endfor

     ;; if first still equals 1, then we've struck out: no matches.
     if( first EQ 1 ) then begin
     		if is_undefined(all_bad) EQ 1 then begin
     			all_bad = targs[itarg]
     		endif else begin
     			all_bad = [ all_bad, targs[itarg] ]    		
     		endelse
     endif else begin

        sxdelpar, output_hdr, "EXPTIME"
        sxaddpar, output_hdr, "EXPTIME", total_exptime
        
        if (file_test('FSpec', /DIR) EQ 0) then spawn, "mkdir FSpec"
        fire_combspec, all_objstr, fspec, FLAG=flag, ERR_MESSAGE=err_message
        if FLAG NE 0 then begin
           if is_undefined(err_message) EQ 1 then err_message = "None provided."
           fire_siren, func_name + ": FAILURE combining " + targs[itarg] + $
                       "!  (Error message: " + err_message + $
                       ")  Skipping this target's correction.", WIDGET=widget, /both, /append
           used(*) = 0     	 
        endif else begin
           fire_1dspec, fspec, outfile, sigfile, hdr=output_hdr, /zero
           if (keyword_set(ORDERS)) then fire_multispec, fspec, outfile, sigfile, hdr=output_hdr
        endelse
        
     endelse
     
		;; Print names of used and unused files to screen
     use_spots = where( used EQ 1, nused, COMPLEMENT=notused_spots, NCOMPLEMENT=nnotused )
     used_tot = used_tot + nused
     notused_tot = notused_tot + nnotused
     if is_undefined(message) then message = make_array( ntargs, 1, /string )
     tmp = "  Object " + strtrim(targs[itarg],2) + ": "
     if nused NE 0 then begin
        tmp = tmp + fire_string(nused) + " file" + s_or_not(nused) + " combined (" + fire_str_array_to_str( objstr_filenames(use_spots) ) + ").  "
     endif else begin
        tmp = tmp + "No files combined!  "		
     endelse
     if nnotused NE 0 then begin
        tmp = tmp +  fire_string(nnotused) + " file" + s_or_not(nnotused) + " NOT combined (" + fire_str_array_to_str( objstr_filenames(notused_spots) ) + ")."
     endif else begin
        tmp = tmp + "No files omitted."			
     endelse
     message(itarg) = tmp
     
  endfor ;; end, cycle through targets

	;; Warn user about objects that had no telluric corrected files.
	if is_undefined(all_bad) EQ 0 then begin
		nall_bad = n_elements(all_bad)
		fire_siren, func_name + ": ERROR!  Could not locate any files which have been " + $
	            "telluric corrected for " + fire_string(nall_bad) + " object" + s_or_not(nall_bad) + $
	            "!: " + fire_str_array_to_str(all_bad) + ".  Please correct tellurics and" + $
	            " then try again.", widget = widget, /both, _EXTRA = keys
	endif
  
	print, func_name + ": Final file checklist:"
	print, message
	print, "  Total: " + fire_string(used_tot) + " used, " + fire_string(notused_tot) + " unused"
	print, func_name + ": Program complete!"    
     
end
