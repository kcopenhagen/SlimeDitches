function laservid(fpath)

    if ~isfile([fpath 'analysis.mat'])
        new_expt(fpath);
    end
    
    load([fpath 'analysis.mat']);
    
    dt = (ts(end)-ts(1))/numel(ts);
    
    fps = 300/dt;
    
    v = VideoWriter([fpath 'laservid.mp4'],'MPEG-4');
    v.Quality = 95;
    v.FrameRate = round(fps);
    open(v);
    
    for t = 1:numel(ts)

        l = laserdata(fpath, t);
        l = l./imgaussfilt(l,64);
        l = normalise(l);
        [cts,eds] = histcounts(l(:));
        [m,i] = max(cts);
        l0 = (eds(i)+eds(i+1))/2;
        l = l-l0;
        
        im = real2rgb(l,gray,[-0.5 0.5]);
        fr = im;
        fr = tandscalebartext(fpath,t,im);
        writeVideo(v, fr);
    end
    close(v);
    
end
    