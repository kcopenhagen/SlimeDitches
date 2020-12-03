function new_expt(fpath)
    ts = getts(fpath);
    save([fpath 'analysis'],'ts');    
end