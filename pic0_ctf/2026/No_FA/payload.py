import base64, zlib, json
payload = ".eJwty0sKgCAQANC7zFoiy19dJoacRPCH2iq6ey7aPngPhOwcWdjhwtAIGORejkZnpT5wUZv8rftIrWMssHOtxay4XuUktJGGCwZ3o5ow0khoo0_wfkceHGc.ab4Ipw._ZZW9RnWjOtFbc0XIL0eiFJioN0".split('.')[1]
print(json.loads(zlib.decompress(base64.urlsafe_b64decode(payload + '=' * (-len(payload) % 4)))))
