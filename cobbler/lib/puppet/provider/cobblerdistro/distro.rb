require 'fileutils'

Puppet::Type.type(:cobblerdistro).provide(:distro) do
    desc "Support for managing the Cobbler distros"

    commands :wget    => 'wget',
             :mount   => 'mount',
             :umount  => 'umount',
             :cp      => 'cp',
             :cobbler => 'cobbler'


    def check_params
        # raise error if destdir is not specified in cobblerdistro manifest definition
        if @resource[:destdir].nil?
            raise ArgumentError, "destdir must be specified in cobblerdistro resource!"
        end
    end
        
    def create
	# sanity check
        check_params

        # add or edit?
        addoredit="edit"
        if cobbler("distro","list").grep(/#{Regexp.escape(@resource[:name])}/).empty?
            addoredit="add"

            # create destination directory for distro
            distrodestdir = @resource[:destdir] + "/" + @resource[:name]
            if ! File.directory? distrodestdir
                Dir.mkdir(distrodestdir)
            end
            # get ISO image
            wget(@resource[:isolink],'--continue','--directory-prefix=/tmp').strip
            # get ISO path
            isopath = "/tmp/" + @resource[:isolink].sub(/^.*\/(.*).iso/, '\1')
            # create mount destination
            if ! File.directory? isopath
                Dir.mkdir(isopath, 755)
            end
            mount( '-o', 'loop', isopath+".iso", isopath)
            # real work to be done here
            currentdir = Dir.pwd 
            Dir.chdir(isopath)
            cp('-R', '.', distrodestdir)
            Dir.chdir(currentdir)
            # clean garbage
            umount( '-f', isopath)
            Dir.delete(isopath)
        end

	# create profileargs variable
        cobblerargs = "distro " + addoredit + " --name=" + @resource[:name]
        cobblerargs += " --kernel=" + @resource[:destdir] + "/" + @resource[:name] + "/images/pxeboot/vmlinuz"
        cobblerargs += " --initrd=" + @resource[:destdir] + "/" + @resource[:name] + "/images/pxeboot/initrd.img"

        # check architecture
        unless @resource[:arch].nil?
            cobblerargs += " --arch=" + @resource[:arch].to_s
        end

	# add distro to cobbler
        cobblerargs = cobblerargs.split(' ')
        cobbler(cobblerargs)
	cobbler("sync")
    end

    def destroy
	# sanity check
        check_params
	# remove distro
        cobbler("distro","remove","--name="+@resource[:name])
	cobbler("sync")
        FileUtils.rm_rf @resource[:destdir] + "/" + @resource[:name]
    end
  
    def exists?
	# sanity check
        check_params
        # check if cobbler has current distro added
	if cobbler("distro","list").grep(/#{Regexp.escape(@resource[:name])}/).empty?
            return false
        else
            namearg="--name=" + @resource[:name]
            # check arch
            unless @resource[:arch].nil?
                if cobbler("distro","report",namearg).grep(/#{@resource[:arch]}/).grep(/Architecture/).empty?
                    return false
                end
            end
            # check if kerne/initrd are OK
            if cobbler("distro","report",namearg).grep(/#{@resource[:destdir]}/).grep(/^Initrd/).empty? or cobbler("distro","report",namearg).grep(/#{@resource[:destdir]}/).grep(/^Kernel/).empty?
                return false
            end
            # check if some dir in ISO hierarchy exists
            File.directory? @resource[:destdir] + "/" + @resource[:name] + "/isolinux"
        end
    end
end
