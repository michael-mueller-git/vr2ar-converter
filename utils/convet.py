
import os
import torch

os.system("mkdir model") 
os.system("cd model") 


model = torch.hub.load("PeterL1n/RobustVideoMatting", "mobilenetv3")  # or "resnet50"
model.cpu()
model.eval()

traced_script_module = torch.jit.trace(model, torch.randn(1, 3, 1024, 1024), strict=False)
traced_script_module.save("rvm_ts.pt")

os.system("wget https://github.com/pnnx/pnnx/releases/download/20231127/pnnx-20231127-ubuntu.zip") 
os.system("unzip pnnx-20231127-ubuntu.zip") 
os.system("./pnnx-20231127-ubuntu/pnnx rvm_ts.pt inputshape=[1,3,1024,1024] device=cpu") 


