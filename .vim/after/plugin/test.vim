" Our standards can put the implementation into either an hpp or cpp file.
" It is possible there is only an h and hpp file (ObservationArtifact) or
" there are all three (PolylineFeatureConsolidator) and you need to know
" which implementation file to switch to.
call lh#alternate#register_extension('g', 'h', ['hpp', 'cpp'])

" The implementation files should always switch back to the h file.
call lh#alternate#register_extension('g', 'hpp', ['h'])
call lh#alternate#register_extension('g', 'cpp', ['h'])

" See the middle of the 'alternate-config' tag (:help alternate-config) for
" information on this setting. These layouts are typical to the code you work
" with. The first finds the directory of the cpp file associated with the h
" file you are in; the second finds the directory of the h file associated
" with the cpp file you are in.
"
" These regexes may need work, you built them yourself from:
" http://www.vimregex.com/
let g:alternates.searchpath='sfr:.,reg:|\(\a\+\)/include/\a\+|\1/src|g|,reg:|\(\a\+\)/src|\1/include/\1|g|'
