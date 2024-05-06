project "CommonLibSSE"
    kind "StaticLib"
    language "C++"
    cppdialect "C++latest"
    staticruntime "off"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "SKSE/Impl/PCH.h"
    pchsource "src/SKSE/Impl/PCH.cpp"

    defines 
    {
        "_CRT_SECURE_NO_WARNINGS",
        "SPDLOG_FMT_EXTERNAL",
        "SPDLOG_COMPILED_LIB",
        "SKYRIM_SUPPORT_AE",
        "BOOST_STL_INTERFACES_DISABLE_CONCEPTS",
        "WINVER=0x0601",
        "_WIN32_WINNT=0x0601",
    }

    includedirs
    {
        "%{prj.location}/include",
        "%{IncludeDir.Spdlog}",
        "%{IncludeDir.Fmt}",
        --"%{IncludeDir.Boost}",
        "%{IncludeDir.Binary_io}",
        "%{IncludeDir.Rapidcsv}",
    }

    files 
    {
        "include/RE/**.h",
        "include/REL/**.h",
        "include/REX/**.h",
        "include/SKSE/**.h",

        "src/RE/**.cpp",
        "src/REL/**.cpp",
        "src/REX/**.cpp",
        "src/SKSE/**.cpp",

        "${prj.name}.natvis"
    }

    links
    {
        "binary_io",
        "Fmt",
        "spdlog",
        "Advapi32.lib",
        "D3D11.lib",
        "D3dcompiler.lib",
        "Dbghelp.lib",
        "DXGI.lib",
        "Ole32.lib",
        "Version.lib",
    }

    filter "action:vs*"
        --buildoptions { "/external:W0" }
        disablewarnings { 
            "4005", -- macro redefinition
            "4061", -- enumerator 'identifier' in switch of enum 'enumeration' is not explicitly handled by a case label
            "4200", -- nonstandard extension used : zero-sized array in struct/union
            "4201", -- nonstandard extension used : nameless struct/union
            "4265", -- 'type': class has virtual functions, but its non-trivial destructor is not virtual; instances of this class may not be destructed correctly
            "4266", -- 'function' : no override available for virtual member function from base 'type'; function is hidden
            "4371", -- 'classname': layout of class may have changed from a previous version of the compiler due to better packing of member 'member'
            "4514", -- 'function' : unreferenced inline function has been removed
            "4582", -- 'type': constructor is not implicitly called
            "4583", -- 'type': destructor is not implicitly called
            "4623", -- 'derived class' : default constructor was implicitly defined as deleted because a base class default constructor is inaccessible or deleted
            "4625", -- 'derived class' : copy constructor was implicitly defined as deleted because a base class copy constructor is inaccessible or deleted
            "4626", -- 'derived class' : assignment operator was implicitly defined as deleted because a base class assignment operator is inaccessible or deleted
            "4710", -- 'function' : function not inlined
            "4711", -- function 'function' selected for inline expansion
            "4820", -- 'bytes' bytes padding added after construct 'member_name'
            "5026", -- 'type': move constructor was implicitly defined as deleted
            "5027", -- 'type': move assignment operator was implicitly defined as deleted
            "5045", -- Compiler will insert Spectre mitigation for memory load if /Qspectre switch specified
            "5053", -- support for 'explicit(<expr>)' in C++17 and earlier is a vendor extension
            "5204", -- 'type-name': class has virtual functions, but its trivial destructor is not virtual; instances of objects derived from this class may not be destructed correctly
            "5220", -- 'member': a non-static data member with a volatile qualified type no longer implies that compiler generated copy / move constructors and copy / move assignment operators are not trivial
        }
        fatalwarnings { 
            "4715", -- 'function' : not all control paths return a value"
        }
        externalanglebrackets "On"
        externalwarnings "Off"

    filter "files:src/RE/**.cpp"
        forceincludes "SKSE/Impl/PCH.h"

    filter "files:src/REL/**.cpp"
        forceincludes "SKSE/Impl/PCH.h"

    filter "files:src/REX/**.cpp"
        forceincludes "SKSE/Impl/PCH.h"

    filter "files:src/SKSE/*.cpp"
        forceincludes "SKSE/Impl/PCH.h"

    filter "files:src/SKSE/Impl/WinAPI.cpp"
        --forceincludes "memory"
        --flags { "NoPCH" }
        forceincludes "SKSE/Impl/PCH.h"

    filter "system:windows"
		systemversion "latest"

		defines
		{
		}

		links
		{
		}

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

        defines { "DEBUG" }

        links
        {
        }

    filter "configurations:Release"
        runtime "Release"
        optimize "On"
        symbols "Off"

        defines { "NDEBUG" }

        links
        {
        }

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"
        symbols "Off"

        defines { "NDEBUG" }

        links
        {
        }