function heightvid(fpath)
    if ~isfile([fpath 'analysis.mat'])
        new_expt(fpath);
    end
    
    load([fpath 'analysis.mat']);
    
    dt = (ts(end)-ts(1))/numel(ts);
    
    fps = 300/dt;
    
    v = VideoWriter([fpath 'Heightvid.mp4'],'MPEG-4');
    v.Quality = 95;
    v.FrameRate = round(fps);
    open(v);
    
    
    
    for t = 1:numel(ts)

        h = heightdata(fpath, t);
        h = h-imgaussfilt(h,64);
        h = h-min(h(:));
        
        [cts,eds] = histcounts(h(:));
        [m,i] = max(cts);
        h0 = (eds(i)+eds(i+1))/2;
        h = h-h0;
        
        im = real2rgb(h,flipud(myxocmap),[-0.2 0.1]);
        fr = tandscalebartext(fpath,t,im);
        writeVideo(v, fr);
    end
    close(v);
end