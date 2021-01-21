#!/usr/bin/env python2
# -*- coding: utf-8 -*-
##################################################
# GNU Radio Python Flow Graph
# Title: Top Block
# Generated: Wed Jan 20 22:05:20 2021
##################################################

if __name__ == '__main__':
    import ctypes
    import sys
    if sys.platform.startswith('linux'):
        try:
            x11 = ctypes.cdll.LoadLibrary('libX11.so')
            x11.XInitThreads()
        except:
            print "Warning: failed to XInitThreads()"

from PyQt4 import Qt
from gnuradio import analog
from gnuradio import blocks
from gnuradio import digital
from gnuradio import eng_notation
from gnuradio import filter
from gnuradio import gr
from gnuradio import qtgui
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from gnuradio.qtgui import Range, RangeWidget
from optparse import OptionParser
import limesdr
import sip
import sys
from gnuradio import qtgui


class top_block(gr.top_block, Qt.QWidget):

    def __init__(self):
        gr.top_block.__init__(self, "Top Block")
        Qt.QWidget.__init__(self)
        self.setWindowTitle("Top Block")
        qtgui.util.check_set_qss()
        try:
            self.setWindowIcon(Qt.QIcon.fromTheme('gnuradio-grc'))
        except:
            pass
        self.top_scroll_layout = Qt.QVBoxLayout()
        self.setLayout(self.top_scroll_layout)
        self.top_scroll = Qt.QScrollArea()
        self.top_scroll.setFrameStyle(Qt.QFrame.NoFrame)
        self.top_scroll_layout.addWidget(self.top_scroll)
        self.top_scroll.setWidgetResizable(True)
        self.top_widget = Qt.QWidget()
        self.top_scroll.setWidget(self.top_widget)
        self.top_layout = Qt.QVBoxLayout(self.top_widget)
        self.top_grid_layout = Qt.QGridLayout()
        self.top_layout.addLayout(self.top_grid_layout)

        self.settings = Qt.QSettings("GNU Radio", "top_block")
        self.restoreGeometry(self.settings.value("geometry").toByteArray())

        ##################################################
        # Variables
        ##################################################
        self.simbolos_por_muestra = simbolos_por_muestra = 5
        self.nfilts = nfilts = 32
        self.variable_qtgui_range_2 = variable_qtgui_range_2 = 50
        self.variable_qtgui_range_1 = variable_qtgui_range_1 = 50
        self.variable_qtgui_range_0 = variable_qtgui_range_0 = 50
        self.signal_bandwidth = signal_bandwidth = 100e3
        self.samp_rate = samp_rate = 1e6
        self.rrc_taps = rrc_taps = firdes.root_raised_cosine(nfilts, nfilts, 1.0/float(simbolos_por_muestra), 0.35, 11*simbolos_por_muestra*nfilts)
        self.interpol = interpol = 50
        self.ex_cess_bw = ex_cess_bw = 350e-3
        self.center_freq = center_freq = 440e6
        self.arity = arity = 2
        self.TX_RX_gain = TX_RX_gain = 53
        self.BPSK = BPSK = digital.constellation_rect(([-1, 1]), ([0, 1]), 4, 2, 2, 1, 1).base()

        ##################################################
        # Blocks
        ##################################################
        self._center_freq_range = Range(400e6, 3e9, 20e6, 440e6, 200)
        self._center_freq_win = RangeWidget(self._center_freq_range, self.set_center_freq, 'Frecuencia central', "counter_slider", float)
        self.top_grid_layout.addWidget(self._center_freq_win)
        self._TX_RX_gain_range = Range(30, 60, 1, 53, 200)
        self._TX_RX_gain_win = RangeWidget(self._TX_RX_gain_range, self.set_TX_RX_gain, 'TX_RX_gain', "counter_slider", float)
        self.top_grid_layout.addWidget(self._TX_RX_gain_win)
        self._variable_qtgui_range_2_range = Range(0, 100, 1, 50, 200)
        self._variable_qtgui_range_2_win = RangeWidget(self._variable_qtgui_range_2_range, self.set_variable_qtgui_range_2, "variable_qtgui_range_2", "counter_slider", float)
        self.top_grid_layout.addWidget(self._variable_qtgui_range_2_win)
        self._variable_qtgui_range_1_range = Range(0, 100, 1, 50, 200)
        self._variable_qtgui_range_1_win = RangeWidget(self._variable_qtgui_range_1_range, self.set_variable_qtgui_range_1, "variable_qtgui_range_1", "counter_slider", float)
        self.top_grid_layout.addWidget(self._variable_qtgui_range_1_win)
        self._variable_qtgui_range_0_range = Range(0, 100, 1, 50, 200)
        self._variable_qtgui_range_0_win = RangeWidget(self._variable_qtgui_range_0_range, self.set_variable_qtgui_range_0, "variable_qtgui_range_0", "counter_slider", float)
        self.top_grid_layout.addWidget(self._variable_qtgui_range_0_win)
        self.qtgui_time_sink_x_1 = qtgui.time_sink_c(
        	1024, #size
        	samp_rate, #samp_rate
        	"", #name
        	1 #number of inputs
        )
        self.qtgui_time_sink_x_1.set_update_time(0.10)
        self.qtgui_time_sink_x_1.set_y_axis(-1, 1)

        self.qtgui_time_sink_x_1.set_y_label('Amplitude', "")

        self.qtgui_time_sink_x_1.enable_tags(-1, True)
        self.qtgui_time_sink_x_1.set_trigger_mode(qtgui.TRIG_MODE_FREE, qtgui.TRIG_SLOPE_POS, 0.0, 0, 0, "")
        self.qtgui_time_sink_x_1.enable_autoscale(False)
        self.qtgui_time_sink_x_1.enable_grid(False)
        self.qtgui_time_sink_x_1.enable_axis_labels(True)
        self.qtgui_time_sink_x_1.enable_control_panel(False)

        if not True:
          self.qtgui_time_sink_x_1.disable_legend()

        labels = ['', '', '', '', '',
                  '', '', '', '', '']
        widths = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        colors = ["blue", "red", "green", "black", "cyan",
                  "magenta", "yellow", "dark red", "dark green", "blue"]
        styles = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        markers = [-1, -1, -1, -1, -1,
                   -1, -1, -1, -1, -1]
        alphas = [1.0, 1.0, 1.0, 1.0, 1.0,
                  1.0, 1.0, 1.0, 1.0, 1.0]

        for i in xrange(2):
            if len(labels[i]) == 0:
                if(i % 2 == 0):
                    self.qtgui_time_sink_x_1.set_line_label(i, "Re{{Data {0}}}".format(i/2))
                else:
                    self.qtgui_time_sink_x_1.set_line_label(i, "Im{{Data {0}}}".format(i/2))
            else:
                self.qtgui_time_sink_x_1.set_line_label(i, labels[i])
            self.qtgui_time_sink_x_1.set_line_width(i, widths[i])
            self.qtgui_time_sink_x_1.set_line_color(i, colors[i])
            self.qtgui_time_sink_x_1.set_line_style(i, styles[i])
            self.qtgui_time_sink_x_1.set_line_marker(i, markers[i])
            self.qtgui_time_sink_x_1.set_line_alpha(i, alphas[i])

        self._qtgui_time_sink_x_1_win = sip.wrapinstance(self.qtgui_time_sink_x_1.pyqwidget(), Qt.QWidget)
        self.top_grid_layout.addWidget(self._qtgui_time_sink_x_1_win)
        self.qtgui_time_sink_x_0 = qtgui.time_sink_c(
        	1024, #size
        	samp_rate, #samp_rate
        	"", #name
        	1 #number of inputs
        )
        self.qtgui_time_sink_x_0.set_update_time(0.10)
        self.qtgui_time_sink_x_0.set_y_axis(-1, 1)

        self.qtgui_time_sink_x_0.set_y_label('Amplitude', "")

        self.qtgui_time_sink_x_0.enable_tags(-1, True)
        self.qtgui_time_sink_x_0.set_trigger_mode(qtgui.TRIG_MODE_FREE, qtgui.TRIG_SLOPE_POS, 0.0, 0, 0, "")
        self.qtgui_time_sink_x_0.enable_autoscale(False)
        self.qtgui_time_sink_x_0.enable_grid(False)
        self.qtgui_time_sink_x_0.enable_axis_labels(True)
        self.qtgui_time_sink_x_0.enable_control_panel(False)

        if not True:
          self.qtgui_time_sink_x_0.disable_legend()

        labels = ['', '', '', '', '',
                  '', '', '', '', '']
        widths = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        colors = ["blue", "red", "green", "black", "cyan",
                  "magenta", "yellow", "dark red", "dark green", "blue"]
        styles = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        markers = [-1, -1, -1, -1, -1,
                   -1, -1, -1, -1, -1]
        alphas = [1.0, 1.0, 1.0, 1.0, 1.0,
                  1.0, 1.0, 1.0, 1.0, 1.0]

        for i in xrange(2):
            if len(labels[i]) == 0:
                if(i % 2 == 0):
                    self.qtgui_time_sink_x_0.set_line_label(i, "Re{{Data {0}}}".format(i/2))
                else:
                    self.qtgui_time_sink_x_0.set_line_label(i, "Im{{Data {0}}}".format(i/2))
            else:
                self.qtgui_time_sink_x_0.set_line_label(i, labels[i])
            self.qtgui_time_sink_x_0.set_line_width(i, widths[i])
            self.qtgui_time_sink_x_0.set_line_color(i, colors[i])
            self.qtgui_time_sink_x_0.set_line_style(i, styles[i])
            self.qtgui_time_sink_x_0.set_line_marker(i, markers[i])
            self.qtgui_time_sink_x_0.set_line_alpha(i, alphas[i])

        self._qtgui_time_sink_x_0_win = sip.wrapinstance(self.qtgui_time_sink_x_0.pyqwidget(), Qt.QWidget)
        self.top_grid_layout.addWidget(self._qtgui_time_sink_x_0_win)
        self.low_pass_filter_0 = filter.fir_filter_ccf(50, firdes.low_pass(
        	1, samp_rate, 50e3, 10e3, firdes.WIN_BLACKMAN, 6.76))
        self.limesdr_source_0 = limesdr.source('1D4C2A4CC49084',
        			 1,
        			 1,
        			 0,
        			 0,
        			 '',
        			 center_freq,
        			 samp_rate,
        			 0,
        			 0,
        			 10e6,
        			 0,
        			 10e6,
        			 3,
        			 2,
        			 2,
        			 1,
        			 5e6,
        			 1,
        			 5e6,
        			 0,
        			 0,
        			 0,
        			 0,
        			 TX_RX_gain,
        			 30,
        			 0,
        			 0,
        			 0,
        			 0)
        self.limesdr_sink_0 = limesdr.sink('1D4C2A4CC49084',
        		       1,
        		       1,
        		       0,
        		       0,
        		       '',
        		       center_freq,
        		       samp_rate,
        		       0,
        		       0,
        		       10e6,
        		       0,
        		       10e6,
        		       1,
        		       1,
        		       1,
        		       1,
        		       5e6,
        		       1,
        		       5e6,
        		       0,
        		       0,
        		       0,
        		       0,
        		       TX_RX_gain,
        		       30,
        		       0,
        		       0,
        		       0,
        		       0)
        self.interp_fir_filter_xxx_0 = filter.interp_fir_filter_ccc(interpol, (rrc_taps))
        self.interp_fir_filter_xxx_0.declare_sample_delay(0)
        self.digital_pfb_clock_sync_xxx_0 = digital.pfb_clock_sync_ccf(simbolos_por_muestra, 62.8e-3, (rrc_taps), 32, 16, 1.5, 1)
        self.digital_diff_decoder_bb_0 = digital.diff_decoder_bb(2)
        self.digital_costas_loop_cc_0 = digital.costas_loop_cc(200e-3, 2, False)
        self.digital_constellation_modulator_0 = digital.generic_mod(
          constellation=BPSK,
          differential=True,
          samples_per_symbol=simbolos_por_muestra,
          pre_diff_code=True,
          excess_bw=0.35,
          verbose=False,
          log=False,
          )
        self.digital_constellation_decoder_cb_0 = digital.constellation_decoder_cb(BPSK)
        self.blocks_pack_k_bits_bb_0 = blocks.pack_k_bits_bb(4)
        self.blocks_multiply_xx_0_0 = blocks.multiply_vcc(1)
        self.blocks_multiply_xx_0 = blocks.multiply_vcc(1)
        self.blocks_file_source_0 = blocks.file_source(gr.sizeof_char*1, 'enviar_por_radio_dog', True)
        self.blocks_file_sink_0 = blocks.file_sink(gr.sizeof_char*1, 'enviado_por_radio_dog', False)
        self.blocks_file_sink_0.set_unbuffered(False)
        self.analog_sig_source_x_0_0 = analog.sig_source_c(samp_rate, analog.GR_COS_WAVE, 200e3, 1, 0)
        self.analog_sig_source_x_0 = analog.sig_source_c(samp_rate, analog.GR_COS_WAVE, 200e3, 1, 0)

        ##################################################
        # Connections
        ##################################################
        self.connect((self.analog_sig_source_x_0, 0), (self.blocks_multiply_xx_0, 1))
        self.connect((self.analog_sig_source_x_0_0, 0), (self.blocks_multiply_xx_0_0, 1))
        self.connect((self.blocks_file_source_0, 0), (self.digital_constellation_modulator_0, 0))
        self.connect((self.blocks_multiply_xx_0, 0), (self.limesdr_sink_0, 0))
        self.connect((self.blocks_multiply_xx_0_0, 0), (self.low_pass_filter_0, 0))
        self.connect((self.blocks_pack_k_bits_bb_0, 0), (self.blocks_file_sink_0, 0))
        self.connect((self.digital_constellation_decoder_cb_0, 0), (self.digital_diff_decoder_bb_0, 0))
        self.connect((self.digital_constellation_modulator_0, 0), (self.interp_fir_filter_xxx_0, 0))
        self.connect((self.digital_costas_loop_cc_0, 0), (self.digital_constellation_decoder_cb_0, 0))
        self.connect((self.digital_diff_decoder_bb_0, 0), (self.blocks_pack_k_bits_bb_0, 0))
        self.connect((self.digital_pfb_clock_sync_xxx_0, 0), (self.digital_costas_loop_cc_0, 0))
        self.connect((self.digital_pfb_clock_sync_xxx_0, 0), (self.qtgui_time_sink_x_1, 0))
        self.connect((self.interp_fir_filter_xxx_0, 0), (self.blocks_multiply_xx_0, 0))
        self.connect((self.interp_fir_filter_xxx_0, 0), (self.qtgui_time_sink_x_0, 0))
        self.connect((self.limesdr_source_0, 0), (self.blocks_multiply_xx_0_0, 0))
        self.connect((self.low_pass_filter_0, 0), (self.digital_pfb_clock_sync_xxx_0, 0))

    def closeEvent(self, event):
        self.settings = Qt.QSettings("GNU Radio", "top_block")
        self.settings.setValue("geometry", self.saveGeometry())
        event.accept()

    def get_simbolos_por_muestra(self):
        return self.simbolos_por_muestra

    def set_simbolos_por_muestra(self, simbolos_por_muestra):
        self.simbolos_por_muestra = simbolos_por_muestra
        self.set_rrc_taps(firdes.root_raised_cosine(self.nfilts, self.nfilts, 1.0/float(self.simbolos_por_muestra), 0.35, 11*self.simbolos_por_muestra*self.nfilts))

    def get_nfilts(self):
        return self.nfilts

    def set_nfilts(self, nfilts):
        self.nfilts = nfilts
        self.set_rrc_taps(firdes.root_raised_cosine(self.nfilts, self.nfilts, 1.0/float(self.simbolos_por_muestra), 0.35, 11*self.simbolos_por_muestra*self.nfilts))

    def get_variable_qtgui_range_2(self):
        return self.variable_qtgui_range_2

    def set_variable_qtgui_range_2(self, variable_qtgui_range_2):
        self.variable_qtgui_range_2 = variable_qtgui_range_2

    def get_variable_qtgui_range_1(self):
        return self.variable_qtgui_range_1

    def set_variable_qtgui_range_1(self, variable_qtgui_range_1):
        self.variable_qtgui_range_1 = variable_qtgui_range_1

    def get_variable_qtgui_range_0(self):
        return self.variable_qtgui_range_0

    def set_variable_qtgui_range_0(self, variable_qtgui_range_0):
        self.variable_qtgui_range_0 = variable_qtgui_range_0

    def get_signal_bandwidth(self):
        return self.signal_bandwidth

    def set_signal_bandwidth(self, signal_bandwidth):
        self.signal_bandwidth = signal_bandwidth

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.qtgui_time_sink_x_1.set_samp_rate(self.samp_rate)
        self.qtgui_time_sink_x_0.set_samp_rate(self.samp_rate)
        self.low_pass_filter_0.set_taps(firdes.low_pass(1, self.samp_rate, 50e3, 10e3, firdes.WIN_BLACKMAN, 6.76))
        self.analog_sig_source_x_0_0.set_sampling_freq(self.samp_rate)
        self.analog_sig_source_x_0.set_sampling_freq(self.samp_rate)

    def get_rrc_taps(self):
        return self.rrc_taps

    def set_rrc_taps(self, rrc_taps):
        self.rrc_taps = rrc_taps
        self.interp_fir_filter_xxx_0.set_taps((self.rrc_taps))
        self.digital_pfb_clock_sync_xxx_0.update_taps((self.rrc_taps))

    def get_interpol(self):
        return self.interpol

    def set_interpol(self, interpol):
        self.interpol = interpol

    def get_ex_cess_bw(self):
        return self.ex_cess_bw

    def set_ex_cess_bw(self, ex_cess_bw):
        self.ex_cess_bw = ex_cess_bw

    def get_center_freq(self):
        return self.center_freq

    def set_center_freq(self, center_freq):
        self.center_freq = center_freq
        self.limesdr_source_0.set_rf_freq(self.center_freq)
        self.limesdr_sink_0.set_rf_freq(self.center_freq)

    def get_arity(self):
        return self.arity

    def set_arity(self, arity):
        self.arity = arity

    def get_TX_RX_gain(self):
        return self.TX_RX_gain

    def set_TX_RX_gain(self, TX_RX_gain):
        self.TX_RX_gain = TX_RX_gain
        self.limesdr_source_0.set_gain(self.TX_RX_gain,0)
        self.limesdr_sink_0.set_gain(self.TX_RX_gain,0)

    def get_BPSK(self):
        return self.BPSK

    def set_BPSK(self, BPSK):
        self.BPSK = BPSK


def main(top_block_cls=top_block, options=None):

    from distutils.version import StrictVersion
    if StrictVersion(Qt.qVersion()) >= StrictVersion("4.5.0"):
        style = gr.prefs().get_string('qtgui', 'style', 'raster')
        Qt.QApplication.setGraphicsSystem(style)
    qapp = Qt.QApplication(sys.argv)

    tb = top_block_cls()
    tb.start()
    tb.show()

    def quitting():
        tb.stop()
        tb.wait()
    qapp.connect(qapp, Qt.SIGNAL("aboutToQuit()"), quitting)
    qapp.exec_()


if __name__ == '__main__':
    main()
