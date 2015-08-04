virtual-shift-tabs.el: Adjust the visual alignment of TABs in unified diffs
===========================================================================

Unified diffs introduce one or more prefix characters that alter the target
column of the displayed TABs. The resulting misalignment may make code
indentation look suspicious and overall harder to read, even though it's
perfectly aligned when the patch is applied.

The function ``virtual-shift-tabs`` can be called in major modes displaying
unified diffs (such as ``diff-mode``, ``magit-diff``, etc) to compensate for
the initial +/- prefix.

In essence, it turns a buffer displaying TABs like this:

.. image:: http://www.thregr.org/~wavexx/rnd/20150805-virtual_shift_tabs/patch-unaligned-2.png

into this:

.. image:: http://www.thregr.org/~wavexx/rnd/20150805-virtual_shift_tabs/patch-aligned-2.png
