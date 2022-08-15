function CreateGroup(groupName, permissions)

	local self = {}

	self.groupName = groupName
	self.permissions = permissions

	function self.getGroupName()
		return self.groupName
	end

	function self.getPermissions()
		return self.permissions
	end

	function self.removePermission(permissionNode)
		self.permissions = ArrayRemove(self.permissions, permissionNode)
	end

	function self.addPermission(permissionNode)
		self.permissions[#self.permissions + 1] = permissionNode
	end

	return self
end
