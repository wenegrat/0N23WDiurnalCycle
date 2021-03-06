% Run Fairall 1996 Model

trange = 1:5967;

met.sw = swnet(trange);
met.lw = lwnet(trange);
met.qlat = latnet(trange);
met.qsens = sensnet(trange);
mld = dataset.density.fulldepth.fullmldh(trange);
met.tx = dataset.measures.tauh(trange);

[Dt U T] = F963(met, mld,dataset.descriptors.datesen(trange), 19, 0.35);
