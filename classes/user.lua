function CreateUser(source, license, permissions, groups)

	local self = {}

	self.source = source
	self.license = license
	self.permissions = permissions
	self.groups = groups

	function self.getSource()
		return self.source
	end

	function self.getLicense()
		return self.license
	end

	function self.getPermissions()
		return self.permissions
	end

	function self.getGroups()
		return self.groups
	end

	function self.removePermission(permissionNode)
		self.permissions = ArrayRemove(self.permissions, permissionNode)
		Log("Removed permission node "..permissionNode.." for license "..self.license,"debug")
	end

	function self.addPermission(permissionNode)
		if not ArrayContains(self.permissions,permissionNode) then
			self.permissions[#self.permissions + 1] = permissionNode
			Log("Added permission node "..permissionNode.." for license "..self.license,"debug")
		end
	end

	function self.removeGroup(groupName)
		self.groups = ArrayRemove(self.groups, groupName)
		Log("Removed group "..groupName.." for license "..self.license,"debug")
	end

	function self.addGroup(groupName)
		if not ArrayContains(self.groups,groupName) then
			self.groups[#self.groups + 1] = groupName
			Log("Added group "..groupName.." for license "..self.license,"debug")
		end
	end

	function self.hasPermission(permissionNode)
		Log("License "..self.license.." Permission Node "..permissionNode.." Status: "..tostring(ArrayContains(self.permissions,permissionNode)),"debug")
		return ArrayContains(self.permissions,permissionNode)
	end

	function self.hasGroup(groupName)
		Log("License "..self.license.." Group "..groupName.." Status: "..ArrayContains(self.permissions,groupName),"debug")
		return ArrayContains(self.groups,groupName)
	end

	function self.toJSON()
		return string.format('{"license":"%s","permissions":%s,"groups":%s}',self.license,json.encode(self.permissions),json.encode(self.groups))
	end

	return self
end
