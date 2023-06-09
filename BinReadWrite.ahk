/*
// Get and return a numerical value from the given buffer (@source) at given
// offset (_offset, in bytes). By default get a UInt/DWORD/Long (4 bytes)
// but _size parameter can be set to another size (in bytes).
// If _bIsSigned is true, interpret the result as signed number.
*/
; @source is a string (buffer) whose memory area contains a raw/binary integer at _offset.
; The caller should pass true for _bIsSigned to interpret the result as signed vs. unsigned.
; _size is the size of @source's integer in bytes (e.g. 4 bytes for a DWORD or Int).
; @source must be ByRef to avoid corruption during the formal-to-actual copying process
; (since @source might contain valid data beyond its first binary zero).
GetInteger(ByRef @source, _offset = 0, _size = 4, _bIsSigned = false)
{
	local result

	Loop %_size%  ; Build the integer by adding up its bytes.
	{
		result += *(&@source + _offset + A_Index-1) << 8*(A_Index-1)
	}
	If (!_bIsSigned OR _size > 4 OR result < 0x80000000)
		Return result  ; Signed vs. unsigned doesn't matter in these cases.
	; Otherwise, convert the value (now known to be 32-bit & negative) to its signed counterpart:
	return -(0xFFFFFFFF - result + 1)
}

/*
// Set a numerical value (_integer) in the given buffer (@dest) at given
// offset (_offset, in bytes). By default set a UInt/DWORD/Long (4 bytes)
// but _size parameter can be set to another size (in bytes).
*/
; The caller must ensure that @dest has sufficient capacity.
; To preserve any existing contents in @dest,
; only _size number of bytes starting at _offset are altered in it.
SetInteger(ByRef @dest, _integer, _offset = 0, _size = 4)
{
	Loop %_size%  ; Copy each byte in the integer into the structure as raw binary data.
	{
		DllCall("RtlFillMemory"
				, "UInt", &@dest + _offset + A_Index-1
				, "UInt", 1
				, "UChar", (_integer >> 8*(A_Index-1)) & 0xFF)
	}
}