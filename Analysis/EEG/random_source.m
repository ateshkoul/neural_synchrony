load vol;
figure;
% head surface (scalp)
ft_plot_mesh(vol.bnd(1), 'edgecolor','none','facealpha',0.8,'facecolor',[0.6 0.6 0.8]);
hold on;
% electrodes
ft_plot_sens(elec,'style', 'k');

mri = ft_read_mri('Subject01.mri');
nas=mri.hdr.fiducial.mri.nas;
lpa=mri.hdr.fiducial.mri.lpa;
rpa=mri.hdr.fiducial.mri.rpa;

transm=mri.transform;

nas=ft_warp_apply(transm,nas, 'homogenous');
lpa=ft_warp_apply(transm,lpa, 'homogenous');
rpa=ft_warp_apply(transm,rpa, 'homogenous');



% create a structure similar to a template set of electrodes
fid.elecpos       = [nas; lpa; rpa];       % ctf-coordinates of fiducials
fid.label         = {'Nz','LPA','RPA'};    % same labels as in elec
fid.unit          = 'mm';                  % same units as mri

% alignment
cfg               = [];
cfg.method        = 'fiducial';
cfg.target        = fid;                   % see above
cfg.elec          = elec;
cfg.fiducial      = {'Nz', 'LPA', 'RPA'};  % labels of fiducials in fid and in elec
elec_aligned      = ft_electroderealign(cfg);


figure;
ft_plot_sens(elec_aligned,'style','k');
hold on;
ft_plot_mesh(vol.bnd(1),'facealpha', 0.85, 'edgecolor', 'none', 'facecolor', [0.65 0.65 0.65]); 


%%
cfg = [];
cfg.method = 'singleshell';
headmodel_meg = ft_prepare_headmodel(cfg, mesh_brain);

headmodel_meg = ft_convert_units(headmodel_meg, 'cm');
