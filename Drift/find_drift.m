function find_drift(fpath)
%%
    if ~isfile([fpath 'analysis.mat'])
        new_expt(fpath);
    end
    
    load([fpath 'analysis.mat'])
    
    h = laserdata(fpath,1);
    h = h./imgaussfilt(h,64);
    h = 2*normalise(h)-1;
    dr = [0 0];
    for t = 2:numel(ts)
        lp = h;
        h = laserdata(fpath,t);
        h = h./imgaussfilt(h,64);
        h = 2*normalise(h)-1;
        hx = xcorr_fft(h,lp);
        p = xcorrpeak(hx);
        center = size(hx')/2+1;
        
        dr = [dr; center-p];
    end
    
    save([fpath 'analysis.mat'],'dr','-append');
end