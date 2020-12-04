function dr_corr_hvid(fpath)

    %%
    
    addpath('../Drift/');
    addpath('../');
    addpath('../Misc. functions');
    if ~isfile([fpath 'analysis.mat'])
        new_expt(fpath);
    end
    load([fpath 'analysis.mat']);
    
    dt = (ts(end)-ts(1))/numel(ts);
    
    fps = 300/dt;
    
    %%
    v = VideoWriter([fpath 'dr_corr_h.avi'],'Uncompressed AVI');
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
        h = heightdata(fpath,t);
        h = h-imgaussfilt(h,64);
        h = h - min(h(:));
         
        [cts,eds] = histcounts(h(:));
        [m,i] = max(cts);
        h0 = (eds(i)+eds(i+1))/2;
        h = h-h0;
        
        h = padarray(h,[100 100],NaN);
        im = h;
        im = h(90+round(sum(dr(1:t,2))):(768+110)+round(sum(dr(1:t,2))),...
            90+round(sum(dr(1:t,1))):(1024+110)+round(sum(dr(1:t,1))));
        im = real2rgb(im,flipud(myxocmap),[-0.2 0.1]);
        im = tandscalebartext(fpath,t,im);
        writeVideo(v, im);
        
    end
    close(v)