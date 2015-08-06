rigid-tabs.el: Rigidify and adjust the visual alignment of TABs
===============================================================

Diffs introduce one or more prefix characters that alter the target column of
the displayed TABs. The resulting misalignment may make code indentation look
suspicious and overall harder to read, even though it's perfectly aligned when
the patch is applied.

``rigid-tabs-mode`` "rigidifies" all TABs in the current buffer, preserving
their width but making them non-flexible just like a block of spaces. This
allows TABs to be shifted without changing their width.

The function ``rigid-tabs-rigid-align`` turns on ``rigid-tabs-mode`` and
adjusts the visual alignment of TABs in major modes displaying diffs (such as
``diff-mode``, ``magit-diff``, etc) to compensate for the initial +/- prefix.
The result is a diff that looks indented as if applied on the source.

To fix alignment in the various diff/magit modes, use ``rigid-tabs-diff-align``
to detect the prefix automatically:

.. code:: elisp

  (add-hook 'diff-mode-hook 'rigid-tabs-diff-align)
  (add-hook 'magit-refresh-buffer-hook 'rigid-tabs-diff-align)

In essence, it turns a buffer displaying TABs like this:

.. image:: http://www.thregr.org/~wavexx/rnd/20150805-rigid_tabs/patch-unaligned-2.png

into this:

.. image:: http://www.thregr.org/~wavexx/rnd/20150805-rigid_tabs/patch-aligned-2.png
