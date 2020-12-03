function dr_corr_lvid(fpath)
    %%
    if ~isfile([fpath 'analysis.mat'])
        new_expt(fpath);
    end
    load([fpath 'analysis.mat']);
    
    dt = (ts(end)-ts(1))/numel(ts);
    
    fps = 300/dt;
    
    %%
    v = VideoWriter([fpath 'dr_corr_l.mp4'],'MPEG-4');
    v.Quality = 95;
    v.FrameRate = round(fps);
    open(v);
    
    %%
    if ~exist('dr','var')
        find_drift(fpath);
        load([fpath 'analysis.mat']);
    end
    
    %%
    for t = 1:numel(ts)
        l = laserdata(fpath,t);
        l = l./imgaussfilt(l,64);
        l = normalise(l);
        [cts,eds] = histcounts(l(:));
        [m,i] = max(cts);
        l0 = (eds(i)+eds(i+1))/2;
        l = l-l0;
        l = padarray(l,[100 100],NaN);
        im = l;
        im = l(90+round(sum(dr(1:t,2))):(768+110)+round(sum(dr(1:t,2))),...
            90+round(sum(dr(1:t,1))):(1024+110)+round(sum(dr(1:t,1))));
        im = real2rgb(im,gray,[-0.5 0.5]);
        im = tandscalebartext(fpath,t,im);
        writeVideo(v, im);
        
    end
    close(v)