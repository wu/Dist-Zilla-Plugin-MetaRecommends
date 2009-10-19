package Dist::Zilla::Plugin::MetaRecommends;
use Moose;

our $VERSION = '0.01';

# ABSTRACT: provide "recommends" section for distribution metadata for optional prereqs
with 'Dist::Zilla::Role::MetaProvider';

has recommends => (
  is       => 'ro',
  isa      => 'HashRef',
  required => 1,
);

sub BUILDARGS {
  my ($class, @arg) = @_;
  my %copy = ref $arg[0] ? %{$arg[0]} : @arg;

  my $zilla = delete $copy{zilla};
  my $name  = delete $copy{plugin_name};

  return {
    zilla => $zilla,
    plugin_name => $name,
    recommends   => \%copy,
  }
}

sub metadata {
  my ($self) = @_;

  return { recommends => $self->recommends };
}

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::MetaRecommends - provide optional prereqs in meta file

=head1 DESCRIPTION

This plugin adds a 'recommends' section to the distribution's metadata
to define any optional prereqs.

  [MetaRecommends]
  module = version
  other::module = version

This module is just a copy of the MetaResources plugin version
1.092680 with a few minor tweaks.


=head1 AUTHOR

  Alex White <VVu@geekfarm.org>


=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Alex White.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
