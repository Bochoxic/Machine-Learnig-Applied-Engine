function [XtNorm,XvNorm]=NormalizacionDatos(XT,XV)
XvNorm=(XV-min(XV))./(max(XV)-min(XV));
XtNorm=(XT-min(XT))./(max(XT)-min(XT));
end
